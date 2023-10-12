# i2p-domain-registry

![](https://img.shields.io/badge/x86-9cf)
![](https://img.shields.io/badge/x86_64-red)
![](https://img.shields.io/badge/ARM_64-ff69b4)
![](https://img.shields.io/badge/ARM_v7-yellow)
![](https://img.shields.io/badge/ARM_v6-green)
![](https://img.shields.io/badge/PowerPC_64_le-blueviolet)
![](https://img.shields.io/badge/IBM_Z-blue)

https://github.com/justin-himself/i2p-subdomain-registry/

## Quickstart 

Place the registry's private key /path/to/config/registry.dat

Place the 2ld.txt in `/path/to/config`.  
Here's a valid 2ld.txt

```
com.i2p
net.i2p
```

Then run

```bash
docker run --name i2p-subdomain-registry \
    -p 8080:8080 \
    --restart always \
    --v /path/to/config:/workdir/config \
    -d justinhimself/i2p-subdomain-registry \
    websrv
```
