[![Docker Stars](https://img.shields.io/docker/stars/durendalz/docker-rubycoind.svg)](https://hub.docker.com/r/durendalz/docker-rubycoind/)
[![Docker Pulls](https://img.shields.io/docker/pulls/durendalz/docker-rubycoind.svg)](https://hub.docker.com/r/durendalz/docker-rubycoind/)
[![ImageLayers](https://images.microbadger.com/badges/image/durendalz/docker-rubycoind.svg)](https://microbadger.com/images/durendalz/docker-rubycoind)

# Rubycoind for Docker

Docker image that runs the Rubycoin rubycoind node in a container for easy deployment.

## Quickstart

Create a basic volume to store the data directory:

        $ docker volume create --name=rubycoind-data

To run:

        $ docker run -d \
        -v rubycoind-data:/rubycoin \
        durendalz/docker-rubycoind:latest

To Find the container ID:

        $ docker container ls

Connect to the instance:

        $ docker exec -it [container id] /bin/bash

Once connected to verify the daemon is synching run:

        # rubycoind \
        -datadir=/rubycoin \
        -conf=/rubycoin/rubycoin.conf \
        getinfo

OR you can directly query rubycoind with:

        $ docker exec \
        -it [container id] \
        rubycoind \
        -datadir=/rubycoin \
        -conf=/rubycoin/rubycoin.conf \
        getinfo

## Setup
In order to setup a Rubycoin node with the default options perform the following steps:

1. Create a volume for the rubycoin data.

        $ docker volume create --name=rubycoind-data

All the data the rubycoind service needs to work will be stored in the volume.
The volume can then be reused to restore the state of the service in case the container needs to be recreated (in case of a host restart or when upgrading the version).

2. Create and run a container with the `docker-rubycoind` image.

        $ docker run -d \
        --name rubycoind-node \
        -v rubycoind-data:/rubycoin \
        -p 5397:5397 \
        --restart unless-stopped \
        durendalz/docker-rubycoind

This will create a container named `rubycoind-node` which gets the host's port 5937 forwarded to it.
Also this container will restart in the event it crashes or the host is restarted.

3. Inspect the output of the container by using docker logs

        $ docker logs -f rubycoind-node

## Configuration Customization

There are 4 different ways to customize the configuration of the `rubycoind` daemon.

### Environment Variables to the Config Generator

If there is no `rubycoin.conf` file in the work directory (`/rubycoin`), the container creates a basic configuration file based on environmental variables.

The following are the environmental variables that can be used to change that default behavior:

- `MAX_CONNECTIONS`: When set (should be an integer), it overrides the max connections value.
- `RPC_SERVER`: If set, it enables the JSON RPC server on port 9332. If no user is given, the user will be set to `rubycoinrpc` and if no password is given a random one will be generated.
The configuration file is the first thing printed by the container and the password can be read from the logs.
- `RPC_USER`: Only used if `RPC_SERVER` is set. This states which user needs to used for the JSON RPC server.
- `RPC_PASSWORD`: Only used if `RPC_SERVER` is set. This states the password to used for the JSON RPC server.

This values can be set by adding a `-e VARIABLE=VALUE` for each of the values that want to be overriden in the `docker run` command (before the image name).

Example:

        $ docker run -d \
        --name rubycoind-node \
        -v rubycoind-data:/rubycoin \
        -p 5397:5397 \
        --restart unless-stopped \
        -e MAX_CONNECTIONS=25 \
        durendalz/docker-rubycoind

### Mounting a `rubycoin.conf` file on `/rubycoin/rubycoin.conf`

If one wants to write their own `rubycoin.conf` and have it persisted on the host but keep all the
`rubycoind` data inside a docker volume one can mount a file volume on `/rubycoin/rubycoin.conf` after the rubycoin data volume.

Example:

        $ docker run -d \
        --name rubycoind-node \
        -v rubycoind-data:/rubycoin \
        -v /etc/rubycoin.conf:/rubycoin/rubycoin.conf \
        -p 5397:5397 \
        --restart unless-stopped \
        durendalz/docker-rubycoind

### Have a `rubycoin.conf` in the rubycoin data directory

Instead of using a docker volume for the rubycoin data, one can mount directory on `/rubycoin` for the container to use as the rubycoin data directory.
If this directory has a `rubycoin.conf` file, this file will be used.

Just create a directory in the host machine (e.g. `/var/rubycoind-data`) and place your `rubycoin.conf` file in it.
Then, when creating the container in the `docker run`, instead of naming a volume to mount use the directory.

        $ docker run -d \
        --name rubycoind-node \
        -v /var/rubycoind-data:/rubycoin \
        -p 5937:5937 \
        --restart unless-stopped \
        durendalz/docker-rubycoind

### Extra arguments to docker run

All the extra arguments given to `docker run` (the ones after the image name) are forwarded to the `rubycoind` process.
This can be used to change the behavior of the `rubycoind` service.

Example:

        $ docker run -d \
        --name rubycoind-node \
        -v rubycoind-data:/rubycoin \
        -p 5937:5937 \
        --restart unless-stopped \
        durendalz/docker-rubycoind \
        -timeout=10000 -proxy=10.0.0.5:3128

_Note: This doesn't prevent the default `rubycoin.conf` file to be created in the volume._
