DOC_ID = 13mTOC6rW6oAOcK6PvoPY2D6shu8PbxC3
BDB_URL = https://drive.google.com/file/d/$(DOC_ID)/view
BDB = database.bdb
IN = bayesrest_api_demo.ipynb
OUT = bayesrest_api_demo_out.ipynb

$(BDB) :
	wget --quiet --output-document=$(BDB) $(BDB_URL)

$(OUT): $(IN) $(BDB)
	docker-compose run notebook jupyter nbconvert\
			--to notebook\
			--execute\
			--ExecutePreprocessor.timeout=60\
			--output $(OUT) $(IN)

fetch: $(BDB)

test: $(OUT)
	echo "Not yet implemented."

clean:
	rm $(BDB) $(OUT)
