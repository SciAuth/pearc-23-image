FROM hub.opensciencegrid.org/osg-jupyter/htc-minimal-notebook:latest

USER root

COPY opt /opt/

USER $NB_UID:$NB_GID

ENTRYPOINT ["tini", "-g", "--", "/opt/sciauth/bin/entrypoint.sh"]
