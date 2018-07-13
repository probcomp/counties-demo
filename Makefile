BDB := bdb/database.bdb
IN := work/demo.ipynb
OUT := out.ipynb

NB_UID := $(shell id -u)

$(OUT): $(IN) $(BDB)
		@NB_UID=${NB_UID} docker-compose\
			-f docker-compose.yml\
			-f docker-compose.test.yml\
			run notebook\
			jupyter nbconvert\
			--to notebook\
			--execute\
			--ExecutePreprocessor.timeout=60\
			--output $(notdir ${OUT}) $(IN)
		mv $(dir ${IN})$(notdir ${OUT}) $(OUT)

up: $(IN)
		@NB_UID=${NB_UID} docker-compose\
			up

dev: $(IN)
	@NB_UID=${NB_UID} docker-compose\
		-f docker-compose.dev.yml\
		up

strip: $(IN)
		@NB_UID=${NB_UID} docker-compose\
			-f docker-compose.yml\
			-f docker-compose.test.yml\
			exec notebook\
			nbstripout $(IN)

test: $(BDB) $(OUT) # TODO: Use docker-compose run to assert on based on the contents of $(OUT)

clean:
	rm $(OUT)
