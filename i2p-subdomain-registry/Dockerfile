FROM golang:alpine as builder

COPY i2p-subdomain-registry /build
WORKDIR /build

RUN go build -o websrv

FROM justinhimself/i2pd-tools as i2pd-tools
FROM alpine

COPY --from=builder /build/websrv /usr/local/bin
COPY --from=i2pd-tools /usr/local/bin/regaddr_3ld /usr/local/bin

COPY i2p-subdomain-registry /workdir
WORKDIR /workdir

EXPOSE 8080