# etcd-registrar
This is an utility that could be used to register service nodes in an ETCD server with TTL so that you can query which nodes are alive from another client.

It uses the lib https://github.com/flaviostutz/etcd-registry.

# Usage - Standalone container

1. Create a docker-compose.yml

```yml
version: '3.5'

services:

  etcd-registrar1:
    build: .
    image: flaviostutz/etcd-registrar
    environment:
      - LOG_LEVEL=debug
      - ETCD_URL=http://etcd0:2379
      - ETCD_BASE=/webservers
      - SERVICE=test1
      - PORT=3000
      - TTL=60
      - INFO=

  etcd-list:
    build: .
    environment:
      - LOG_LEVEL=debug
      - ETCD_URL=http://etcd0:2379
      - ETCD_BASE=/webservers
      - SERVICE=test1
      - LIST=true

  etcd0:
    image: quay.io/coreos/etcd:v3.2.25
    environment:
      - ETCD_LISTEN_CLIENT_URLS=http://0.0.0.0:2379
      - ETCD_ADVERTISE_CLIENT_URLS=http://etcd0:2379

```

2. Run ```docker-compose up```

### Container ENVs

    * LOG_LEVEL=debug
    * ETCD_URL=http://etcd0:2379
    * ETCD_BASE=/webservers
    * SERVICE=test1
    * PORT=3000
    * TTL=60
    * INFO={"weight":0.3,"address":"172.16.5.4"}


## Usage - run along with monitored service

* Extract the executable from the container at /bin/etcd-registrar to run elsewhere

* Command line flags:

```
etcd-registrar \
    --loglevel=info \
    --etcd-url=http://etcd0:2379 \
    --etcd-base=/myservices \
    --service=service1 \
    --port=3000 \
    --info={weight:0.3} \
    --ttl=60
```

* See a complete example at http://github.com/labbsr0x/convid-ssh-server

## Usage - running as a library

* Use github.com/flaviostutz/etcd-registry
