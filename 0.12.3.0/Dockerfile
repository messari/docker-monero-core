FROM debian:stable-slim

RUN useradd -r monero \
  && apt-get update -y \
  && apt-get install -y curl gnupg bzip2 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && set -ex \
  && for key in \
    B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    FE3348877809386C \
  ; do \
    gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
    gpg --keyserver keyserver.pgp.com --recv-keys "$key" || \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" || \
    gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" ; \
  done

ENV GOSU_VERSION=1.10

RUN curl -o /usr/local/bin/gosu -fSL https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture) \
  && curl -o /usr/local/bin/gosu.asc -fSL https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-$(dpkg --print-architecture).asc \
  && gpg --verify /usr/local/bin/gosu.asc \
  && rm /usr/local/bin/gosu.asc \
  && chmod +x /usr/local/bin/gosu

ENV MONERO_VERSION=v0.12.3.0
ENV MONERO_DATA=/home/monero/.monero
ENV MONERO_SHASUM="72fe937aa2832a0079767914c27671436768ff3c486597c3353a8567d9547487 monero-linux64-${MONERO_VERSION}.tar.bz2"

RUN echo "https://github.com/monero-project/monero/releases/download/${MONERO_VERSION}/monero-linux-x64-${MONERO_VERSION}.tar.bz2"
RUN echo "${MONERO_SHASUM}"

RUN curl -LO  https://github.com/monero-project/monero/releases/download/${MONERO_VERSION}/monero-linux-x64-${MONERO_VERSION}.tar.bz2

RUN ls *.tar.bz2 \
  && tar -xjf *.tar.bz2 \
  && mv "monero-${MONERO_VERSION}"/* /usr/local/bin \
  && rm *.tar.bz2 \
  && rmdir "monero-${MONERO_VERSION}"

RUN ls /usr/local/bin

COPY docker-entrypoint.sh /entrypoint.sh

VOLUME ["/home/monero/.monero"]

EXPOSE 18080
EXPOSE 18081

ENTRYPOINT ["/entrypoint.sh"]

CMD ["monerod"]
