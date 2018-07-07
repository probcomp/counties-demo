# jupyter project recommends pinning the base image: https://github.com/jupyter/docker-stacks#other-tips-and-known-issues
FROM jupyter/minimal-notebook:92fe05d1e7e5

USER root

COPY ./requirements.txt /tmp/requirements.txt

USER $NB_USER

RUN /opt/conda/bin/pip install -r /tmp/requirements.txt

ENTRYPOINT ["tini", "--"]

# The start-notebook.sh script is about late-creation of the jovyan user and housekeeping to ensure permissions are correct for that user in the home directory and the conda directory.
CMD ["start-notebook.sh"]
