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
FROM lscr.io/linuxserver/jellyfin

COPY append_hosts.sh /
RUN apt update &&\
    apt -y install dnsutils &&\
    apt clean &&\
    rm -rf /var/lib/apt/lists/*

RUN bash /append_hosts.sh &&\
    cat /etc/hosts
```