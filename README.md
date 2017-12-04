# docker-syncthing-arm
Dockerized Syncthing for arm32v6/alpine

```docker run -d --restart=always --name alpine-syncthing -v /srv/sync:/srv/data -v /srv/syncthing:/srv/config -p 22000:22000  -p 21025:21025/udp -p 8384:8384 azcoigreach/alpine-syncthing```