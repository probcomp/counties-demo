# jupyter project recommends pinning the base image: https://github.com/jupyter/docker-stacks#other-tips-and-known-issues
FROM jupyter/minimal-notebook:92fe05d1e7e5

USER root

COPY *.ipynb /home/$NB_USER/

# need to run this here so the fix-permissions script succeeds later
RUN chown -R $NB_USER /home/$NB_USER

USER $NB_USER

ENTRYPOINT      ["tini", "--"]
CMD             ["start-notebook.sh"]
