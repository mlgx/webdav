# WebDAV

Dockerized WebDAV server.  
Docker Hub: https://hub.docker.com/r/mlgx/webdav

No user and password are required to connect to the WebDAV server.  
If a client forces you to enter a user and password just smash random keys.

## Example docker run

```
docker run \
    --name webdav \
    --port 172.17.0.1:8080:80 \
    --volume $HOME/docker/media:/webdav \
    --detach \
    mlgx/webdav
```

## Example docker-compose

```
version: "2.0"

services:
  webdav:
    image: mlgx/webdav
    container_name: webdav
    ports:
      - 172.17.0.1:8080:80
    volumes:
      - $HOME/docker/media:/webdav
```
