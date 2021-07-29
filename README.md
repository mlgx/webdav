# WebDAV

Dockerized WebDAV server.  
Docker Hub: https://hub.docker.com/r/mlgx/webdav

## Example docker run

```
docker run --name webdav --port 172.17.0.1:8082:80 --volume $HOME/docker/media:/webdav --detach mlgx/webdav
```

## Example docker-compose

```
version: "1"

services:
  webdav:
    image: mlgx/webdav
    container_name: webdav
    ports:
      - 172.17.0.1:8082:80
    volumes:
      - $HOME/docker/media:/webdav
```
