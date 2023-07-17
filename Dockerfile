FROM hub.opensciencegrid.org/osg-jupyterhub/htc-minimal-notebook:2.0.0


## Update the base install, and install packages.


USER root

RUN apt-get update -y \
    && apt-get upgrade -y \
    #
    # START: Needed only for Ubuntu 20 and earlier.
    #
    # && apt-get install -y curl \
    # && curl https://repo.data.kit.edu/repo-data-kit-edu-key.gpg \
    #      | gpg --dearmor \
    #      > /etc/apt/trusted.gpg.d/kit-repo.gpg \
    # && echo "deb https://repo.data.kit.edu/ubuntu/focal ./" \
    #      >> /etc/apt/sources.list \
    # && apt-get update -y \
    #
    # END: Needed only for Ubuntu 20 and earlier.
    #
    && apt-get install -y apache2 oidc-agent \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

USER $NB_UID:$NB_GID

RUN python3 -m pip install -U --no-cache-dir \
      bash_kernel \
      scitokens \
    && python3 -m bash_kernel.install --sys-prefix


## Configure services and container startup.


USER root

COPY build /build/
COPY etc /etc/
COPY image-init.d /image-init.d/
COPY www /www/

RUN mkdir -p /certs/ \
    && openssl req -x509 \
         -subj "/CN=localhost" \
         -newkey rsa:4096 \
         -out /certs/tls.crt \
         -keyout /certs/tls.key \
         -days 365 \
         -nodes \
         -sha256 \
         -extensions san \
         -config /build/tls.req \
    && /build/add_cert.py /certs/tls.crt /etc/ssl/certs/ca-certificates.crt \
    && chmod a+r /certs/tls.crt /certs/tls.key \
    #
    && /build/configure_apache2.sh \
    && a2enmod ssl \
    && a2ensite 001-token-issuer \
    && a2dissite 000-default \
    #
    && chown -R $NB_UID:$NB_GID /www/ \
    #
    && git clone https://github.com/SciAuth/pearc-23-notebook.git /demo-init.d/SciAuth-Tutorial \
    && git clone https://github.com/SciAuth/scitoken-demo.git /demo-init.d/SciTokens-Demo


## Ensure that the container runs as 'jovyan' by default.


USER $NB_UID:$NB_GID
