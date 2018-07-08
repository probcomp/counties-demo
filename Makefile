BDB := database.bdb
IN := demo/demo.ipynb
OUT := out.ipynb

$(OUT): $(IN) $(BDB)
		docker-compose\
			-f docker-compose.yml\
			-f docker-compose.test.yml\
			run\
			-u jovyan\
			notebook jupyter nbconvert\
			--to notebook\
			--execute\
			--ExecutePreprocessor.timeout=60\
			--output $(notdir ${OUT}) $(IN)
		mv $(dir ${IN})$(notdir ${OUT}) $(OUT)

test: $(OUT) # TODO: Use docker-compose run to assert on based on the contents of $(OUT)

clean:
	rm $(OUT)
