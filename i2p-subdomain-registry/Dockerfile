FROM golang:1.21-alpine as builder

COPY i2p-subdomain-registry /build
WORKDIR /build

RUN go build -o websrv

FROM justinhimself/i2pd-tools as i2pd-tools
FROM alpine

COPY --from=builder /build/websrv /usr/local/bin
COPY --from=i2pd-tools /usr/local/bin/regaddr_3ld /usr/local/bin
COPY i2p-subdomain-registry /workdir

RUN \
    apk --no-cache add boost-filesystem boost-chrono \
    boost-program_options boost-date_time \
    libssl1.1 zlib \
    
WORKDIR /workdir
EXPOSE 8080
