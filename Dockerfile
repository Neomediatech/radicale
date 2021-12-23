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
        python3 python3-pip bash curl \
    ; \
    pip3 install --upgrade pip && \
    pip3 install radicale~=3.0 && \
    pip3 install --upgrade https://github.com/Unrud/RadicaleIMAP/archive/master.tar.gz
#    python3 -m pip install --upgrade https://github.com/Unrud/RadicaleIMAP/archive/master.tar.gz

COPY radicale.conf /radicale.conf

EXPOSE 5232/tcp
VOLUME ["/data"]

CMD radicale -S -C /radicale.conf

HEALTHCHECK CMD curl -f -L http://localhost:5232/ || exit 1
RUN echo $VERSION >> /version

