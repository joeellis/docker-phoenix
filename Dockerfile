FROM gliderlabs/alpine:3.3
MAINTAINER Joe Ellis "joe@joeellis.la"

ENV REFRESHED_AT 2016-05-14
ENV ELIXIR_VERSION 1.2.4
ENV PATH $PATH:/opt/elixir-${ELIXIR_VERSION}/bin

RUN apk --update add build-base \
                     bash \
                     ca-certificates \
                     erlang \
                     erlang-crypto \
                     erlang-syntax-tools \
                     erlang-parsetools \
                     erlang-inets \
                     erlang-ssl \
                     erlang-public-key \
                     erlang-eunit \
                     erlang-asn1 \
                     erlang-sasl \
                     erlang-erl-interface \
                     erlang-dev \
                     git \
                     inotify-tools \
                     postgresql-client \
                     wget && \
    rm -rf /var/cache/apk/* && \
    update-ca-certificates

RUN apk --update add --virtual build-dependencies wget ca-certificates && \
    wget https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip && \
    mkdir -p /opt/elixir-${ELIXIR_VERSION}/ && \
    unzip Precompiled.zip -d /opt/elixir-${ELIXIR_VERSION}/ && \
    rm Precompiled.zip && \
    apk del build-dependencies && \
    rm -rf /etc/ssl && \
    rm -rf /var/cache/apk/* && \
    mix local.hex --force && \
    mix local.rebar --force && \
    mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force
