FROM hub.opensciencegrid.org/osg-jupyterhub/htc-minimal-notebook:1.5.0

## Update the base install.

USER root

RUN apt-get update -y \
    && apt-get upgrade -y \
    #
    # START: Needed only for Ubuntu 20 and earlier.
    #
    && apt-get install -y curl \
    && curl https://repo.data.kit.edu/repo-data-kit-edu-key.gpg \
         | gpg --dearmor \
         > /etc/apt/trusted.gpg.d/kit-repo.gpg \
    && echo "deb https://repo.data.kit.edu/ubuntu/focal ./" \
         >> /etc/apt/sources.list \
    && apt-get update -y \
    #
    # END: Needed only for Ubuntu 20 and earlier.
    #
    && apt-get install -y apache2 oidc-agent \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

COPY build /build/
COPY etc /etc/
COPY image-init.d /image-init.d/

RUN chmod go= /etc/sudoers.d/91-allow-apachectl \
    #
    && mkdir /certs/ \
    && /build/make_cert.sh \
    && /build/add_cert.py /certs/tls.crt /etc/ssl/certs/ca-certificates.crt \
    #
    && mkdir /token-issuer/ \
    && chown $NB_UID:$NB_GID /token-issuer/ \
    #
    && a2enmod ssl \
    && a2ensite 001-token-issuer \
    && a2dissite 000-default

USER $NB_UID:$NB_GID

## Install packages and Jupyter kernels needed by the tutorial.

RUN python3 -m pip install -U --no-cache-dir \
      pip \
      setuptools \
      wheel \
    && python3 -m pip install -U --no-cache-dir \
      bash_kernel \
      scitokens \
    && python3 -m bash_kernel.install --sys-prefix
