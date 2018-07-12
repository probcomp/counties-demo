# jupyter project recommends pinning the base image: https://github.com/jupyter/docker-stacks#other-tips-and-known-issues
FROM jupyter/minimal-notebook:92fe05d1e7e5

USER root

ENV DOCKERIZE_VERSION v0.6.1
RUN wget --quiet https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz
COPY files/docker-entrypoint.sh /usr/local/bin/

COPY requirements.txt /tmp/requirements.txt
RUN pip install --upgrade pip

RUN pip install nbstripout

# dependencies for accessing bayesrest
RUN pip install requests

RUN pip install plotly
RUN pip install colour
RUN pip install pandas==0.22.0

## dependencies for plotly
RUN pip install matplotlib==2.2.2

## dependencies for plotly _county_choropleth.py figure factory
RUN pip install geopandas==0.3.0
RUN pip install pyshp==1.2.10
RUN pip install shapely==1.6.3


ENTRYPOINT ["tini", "--", "docker-entrypoint.sh"]
CMD ["start-notebook.sh"]

