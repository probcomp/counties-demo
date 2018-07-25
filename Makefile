BDB := bdb/counties_v6.bdb
IN := work/demo.ipynb
OUT := out.ipynb
TAR := loom/loom.tar

NB_UID := $(shell id -u)

$(OUT): $(IN) $(BDB)
		sha256sum bdb/counties_v6.bdb
		@NB_UID=${NB_UID} docker-compose\
			-f docker-compose.yml\
			-f docker-compose.test.yml\
			run -d notebook\
			jupyter nbconvert\
			--to notebook\
			--execute\
			--ExecutePreprocessor.timeout=60\
			--output $(notdir ${OUT}) $(IN)
		docker-compose logs -f
		mv $(dir ${IN})$(notdir ${OUT}) $(OUT)


up: $(IN)
		@NB_UID=${NB_UID} docker-compose\
			up

strip: $(IN)
		@NB_UID=${NB_UID} docker-compose\
			-f docker-compose.yml\
			-f docker-compose.test.yml\
			exec notebook\
			nbstripout $(IN)

package:
		tar -cvf $(TAR) loom/*

extract: $(TAR)
		tar -xvf loom/loom.tar

test: $(BDB) $(OUT) # TODO: Use docker-compose run to assert on based on the contents of $(OUT)

clean:
	rm $(OUT)
