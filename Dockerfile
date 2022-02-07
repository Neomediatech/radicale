FROM neomediatech/ubuntu-base:20.04

ENV VERSION=$VERSION \
    SERVICE=radicale

LABEL maintainer="docker-dario@neomediatech.it" \ 
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-type=Git \
      org.label-schema.vcs-url=https://github.com/Neomediatech/${SERVICE} \
      org.label-schema.maintainer=Neomediatech


RUN set -ex; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        python3 python3-pip bash curl && \
    pip3 install --upgrade pip && \
    pip3 install radicale~=3.0 && \
    pip3 install --upgrade https://github.com/Unrud/RadicaleIMAP/archive/master.tar.gz && \
    pip3 install --upgrade https://github.com/Unrud/RadicaleInfCloud/archive/master.tar.gz
    # from Radicale developer repo

COPY radicale.conf /radicale.conf
COPY entrypoint.sh /entrypoint.sh

EXPOSE 5232/tcp
VOLUME ["/data"]

#CMD radicale -S -C /data/radicale.conf

HEALTHCHECK --interval=60s --timeout=30s --start-period=10s --retries=5 CMD curl -I -s -L http://localhost:5232/.web/ || exit 1

RUN radicale --version >> /version ; \
    chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/tini","--","radicale","-S","-C","/data/radicale.conf"]

