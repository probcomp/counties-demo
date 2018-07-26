# counties-demo [![Build Status](https://travis-ci.org/probcomp/counties-demo.svg?branch=master)](https://travis-ci.org/probcomp/counties-demo)

## What the counties-demo repo is

The `counties-demo` repo contains a Jupyter notebook that demonstrates the capabilities of the Bayesian Database Search API.  We have loaded the API with a tabular dataset of over 3,000 counties (rows) and about 130 demographic, income, drug use, and political statistics (columns) of each of those counties.  And we demonstrate the API with this Jupyter notebook by calling three of the API's endpoints.  Further documentation on the API can be found [here](https://github.com/probcomp/bayesrest).

## Getting Started

Before you can use this repo, you will need to install [Git LFS](https://git-lfs.github.com/).  If you're on a Mac and have homebrew installed, this should be as simple as `brew install git-lfs`.

Once you have Git LFS installed, clone this repo, open it in your terminal, and run `make extract && make up`.

After 2 or 3 minutes of loading, your terminal should log a URL that looks something like this: `http://localhost:8888/?token=58b764b34cbc6c9831ac1e4ea21b5ef5619f52448e2561c9`

Open a browser and paste in the above URL.  You should be taken to a Jupyter notebook, which has a directory called `work`.  Click on that directory, and you should then see two files: `demo.ipynb` and `visualize.py`.  Click on `demo.ipynb` and you will be brought to the demo Jupyter notebook, which you can then walk through.