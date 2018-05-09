FROM alpine/git

LABEL maintainer Ilya Kislenko <ilya@kasten.io>

COPY install.sh install.sh
RUN ./install.sh

VOLUME /git
WORKDIR /git

ENTRYPOINT [ "hub" ]
