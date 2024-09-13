FROM alpine AS base

ARG HBASE_VERSION=2.6.0

WORKDIR /app

RUN apk add jq bash

RUN URL=`wget -q -O - 'https://www.apache.org/dyn/closer.cgi?as_json=1' | jq --raw-output '.preferred'` wget -q -O - $URL/hbase/${HBASE_VERSION}/hbase-${HBASE_VERSION}-bin.tar.gz \
    | tar zxf -

RUN mv hbase-* hbase

FROM eclipse-temurin:17

ENV HBASE_HOME=/app/hbase

COPY --from=base /app/hbase $HBASE_HOME
COPY hbase-site.xml $HBASE_HOME/conf/

WORKDIR /app
COPY --chmod=755 docker-entrypoint.sh .
ENTRYPOINT ["/app/docker-entrypoint.sh"]
