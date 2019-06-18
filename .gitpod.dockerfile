FROM gitpod/workspace-full:latest

USER root

RUN apt-get update && apt-get install -y \
    && go get -u v2ray.com/core/... \
    && mkdir -p /usr/bin/v2ray/ \
    && CGO_ENABLED=0 go build -o /usr/bin/v2ray/v2ray v2ray.com/core/main \
    && CGO_ENABLED=0 go build -o /usr/bin/v2ray/v2ctl v2ray.com/core/infra/control/main \
    && cp -r ${GOPATH}/src/v2ray.com/core/release/config/* /usr/bin/v2ray/ \
    && apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*

USER gitpod

ENV PATH /usr/bin/v2ray/:$PATH

USER root