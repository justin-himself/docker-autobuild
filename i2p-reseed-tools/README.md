## LookBusy

![](https://img.shields.io/badge/x86-9cf)
![](https://img.shields.io/badge/x86_64-red)
![](https://img.shields.io/badge/ARM_64-ff69b4)
![](https://img.shields.io/badge/ARM_v7-yellow)
![](https://img.shields.io/badge/ARM_v6-green)
![](https://img.shields.io/badge/PowerPC_64_le-blueviolet)
![](https://img.shields.io/badge/IBM_Z-blue)

> Multiarch alpine image for [MDrollette/i2p-tools](https://github.com/MDrollette/i2p-tools)

This tool provides a secure and efficient reseed server for the I2P network. There are several utility commands to create, sign, and validate SU3 files.

*The Origin repository has been archived on Oct 8 2023, so the image will only be built once a year to bump the golang version.*

## Quickstart

```
docker run --rm -it \
    justinhimself/i2p-reseed-tools \
    reseed-tools -h
```

## Usage 

### First time config

If this is your first time running a reseed server (ie. you don't have any existing keys), 
you can simply run the command and follow the prompts to create the appropriate keys, crl and certificates.
Afterwards an HTTPS reseed server will start on the default port and generate 6 files in your current directory 
(a TLS key, certificate and crl, and a su3-file signing key, certificate and crl).

```bash
docker run --rm -it \
    --name i2p-reseed-server \
    -p 8443:8443 \
    -v /tmp/_data/netDb:/netDb \
    -v /tmp/config:/workdir \
    justinhimself/i2p-reseed-tools \
    reseed-tools reseed --signer=you@mail.i2p --netdb=/netDb
```

Ctrl-C to exit the server and restart with the following commands with your generated cert files.

### Locally behind a webserver (reverse proxy setup), preferred:

```bash
docker run \
    --name i2p-reseed-server \
    --restart always \
    -p 8443:8443 \
    -v /path/to/your/netDb:/netDb \
    -v /path/to/your/reseed-server/config:/workdir \
    -d justinhimself/i2p-reseed-tools \
    reseed-tools reseed --signer=you@mail.i2p --netdb=/netDb --port=8443 --ip=0.0.0.0 --trustProxy
```

### Without a webserver, standalone with TLS support

```bash
docker run -it \
    --name i2p-reseed-server \
    --restart always \
    -p 443:443 \
    -v /path/to/your/netDb:/netDb \
    -v /path/to/your/reseed-server/config:/workdir \
    justinhimself/i2p-reseed-tools \
    reseed-tools reseed --signer=you@mail.i2p --netdb=/netDb --tlsHost=your-domain.tld
```


Get the source code here on github or a pre-build binary anonymously on 

http://reseed.i2p/
http://j7xszhsjy7orrnbdys7yykrssv5imkn4eid7n5ikcnxuhpaaw6cq.b32.i2p/

also a short guide and complete tech info.

