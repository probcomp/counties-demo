# jupyter project recommends pinning the base image: https://github.com/jupyter/docker-stacks#other-tips-and-known-issues
FROM jupyter/minimal-notebook:92fe05d1e7e5

USER root

COPY ./requirements.txt /tmp/requirements.txt

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN /opt/conda/bin/pip install -r /tmp/requirements.txt

COPY files/docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["dockerize", "-wait", "tcp://bayesrest:5000"]
CMD ["start-notebook.sh"]

USER $NB_USER
