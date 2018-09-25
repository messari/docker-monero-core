FROM debian:stable-slim

RUN useradd -r monero \
  && apt-get update -y \
  && apt-get install -y curl gnupg \
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
ENV MONERO_SHASUM="39d40e2001ca9948f434637c28b3933c0d79c66e2db07ffc4274711ab2d2ae66  monero-linux64-${MONERO_VERSION}.tar.bz2"

RUN curl -LO  https://github.com/monero-project/monero/releases/download/${MONERO_VERSION}/monero-linux-x64-${MONERO_VERSION}.tar.bz2 \
  && echo "${MONERO_SHASUM}" | sha256sum -c \
  && tar --strip=2 -xzf *.tar.gz -C /usr/local/bin \
  && rm *.tar.gz

COPY docker-entrypoint.sh /entrypoint.sh

VOLUME ["/home/monero/.monero"]

EXPOSE 18080 18081

ENTRYPOINT ["/entrypoint.sh"]

CMD ["monerod"]
