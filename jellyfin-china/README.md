## Jellyfin China

![](https://img.shields.io/badge/x86_64-red)
![](https://img.shields.io/badge/ARM_64-ff69b4)

> This image is built based on `linuxserver/jellyfin`

This image adds modified hosts file to help jellyfin users in China access *The movie db* and *The open movie db*.

### How to use 

This image is fully compatible with original linuxserver's jellyfin build. Simpy substitute:

```
linuxserver/jellyfin -> justinhimself/jellyfin-china
lscr.io/linuxserver/jellyfin -> justinhimself/jellyfin-china
```


### Dockerfile

```dockerfile
FROM debian as builder

WORKDIR /
COPY append_hosts.sh /
RUN apt update && apt -y install dnsutils
RUN bash /append_hosts.sh

FROM lscr.io/linuxserver/jellyfin
COPY --from=builder /etc/hosts /etc/hosts
```