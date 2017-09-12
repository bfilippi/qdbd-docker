## QuasarDB Dockerfile

This repository contains the **Dockerfile** of [QuasarDB](http://www.quasardb.net/) for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/bureau14/qdb/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).

### Supported tags

|tag|description|
|---|---|
|`latest`|latest stable release|
|`nightly`|bleeding edge|

### Base Docker Image

* [dockerfile/ubuntu](http://dockerfile.github.io/#/ubuntu)

### Installation

1. Install [Docker](https://www.docker.com/).

2. Download [automated build](https://registry.hub.docker.com/u/bureau14/qdb/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull bureau14/qdb`

   (alternatively, you can build an image from Dockerfile: `docker build -t="qdb" github.com/bureau14/qdbd-docker`)

### Usage

#### Run `qdbd`

    docker run -it -p 8081:8081 -p 2836:2836 -p 8080:8080  --mount source=quasardb,target=/var/lib/qdb/db --name qdb-server bureau14/qdb

    Monitoring will run from your browser http://127.0.0.1:8080
    Python notebook will run from your browser http://127.0.0.1:8081
    External APIs can connect to qdb://127.0.0.1:2836

#### Run `qdbd` w/ user host directory

docker run -it -p 8081:8081 -p 2836:2836 -p 8080:8080   --mount source=quasardb,target=/var/lib/qdb/db -v <user-dir>:/var/lib/qdb/user --name qdb-server bureau14/qdb

#### Run `qdbd` w/ license file and persistent directory

    # Put the license.txt file in the root of your <user-dir>
    cp license.txt <user-dir>

    # Now launch the docker container with the <user-dir> mounted, the container will
    # pick up the license file automatically.
    docker run -it -p 8081:8081 -p 2836:2836 -p 8080:8080   --mount source=quasardb,target=/var/lib/qdb/db -v <user-dir>:/var/lib/qdb/license --name qdb-server bureau14/qdb
