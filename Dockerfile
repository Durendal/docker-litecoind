FROM ubuntu:zesty

LABEL maintainer "Brian Hewitt <durendal@durendals-domain.com>"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        build-essential \
        libssl-dev \
        libdb++-dev \
        libboost-all-dev \
        make \
        dirmngr


RUN \
    git clone https://github.com/rubycoinorg/rubycoin.git && \
    cd rubycoin/src && \
    make -f makefile.unix && \
    mv rubycoind /usr/local/bin/ && \

RUN apt-get remove --purge -y \
        git \
        build-essential \
        libssl-dev \
        libdb++-dev \
        libboost-all-dev \
        make \
        dirmngr && \
    apt-get autoremove --purge -y

VOLUME ["/rubycoin"]

EXPOSE 5317 5318

COPY ["bin", "/usr/local/bin/"]
COPY ["docker-entrypoint.sh", "/usr/local/bin/"]
ENTRYPOINT ["docker-entrypoint.sh"]
