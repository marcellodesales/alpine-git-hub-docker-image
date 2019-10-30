FROM alpine/git

LABEL maintainer marcello.desales@gmail.com

RUN apk add --update --no-cache curl curl-dev jq bash openssh libc6-compat

RUN LATEST_VERSION=$(curl -s https://api.github.com/repos/github/hub/releases/latest | jq -r '.assets[].browser_download_url' | grep linux-amd64) && \
    echo "Latest version: $LATEST_VERSION" && curl -s -L -o /tmp/hub.tgz $LATEST_VERSION && ls -la /tmp/hub.tgz
RUN mkdir /hub && \
    tar -xvf /tmp/hub.tgz -C /hub --strip-components 1 && \
    alias git=hub && \
    bash /hub/install && \
    hub --version && \
    rm -v /tmp/hub.tgz && rm -frv /hub

VOLUME /git
WORKDIR /git

ENTRYPOINT [ "hub" ]
