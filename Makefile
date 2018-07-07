BDB = database.bdb
IN = bayesrest_api_demo.ipynb
OUT = bayesrest_api_demo_out.ipynb

# These commands are meant to be invoked from the Docker host!

$(BDB) : # TODO: Write a task to fetch the `bdb`. file
	echo "Not yet implemented." && exit 1

$(OUT): $(IN) $(BDB)
	docker-compose run notebook jupyter nbconvert\
			--to notebook\
			--execute\
			--ExecutePreprocessor.timeout=60\
			--output $(OUT) $(IN)

fetch: $(BDB)

test: $(OUT) # TODO: Use docker-compose run to assert on based on the contents of $(OUT)
	echo "Not yet implemented." && exit 1

clean:
	rm $(BDB) $(OUT)
