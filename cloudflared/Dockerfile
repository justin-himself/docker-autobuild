# use a builder image for building cloudflare
ARG TARGET_GOOS
ARG TARGET_GOARCH
FROM golang:1.17.1 as builder
ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    TARGET_GOOS=${TARGET_GOOS} \
    TARGET_GOARCH=${TARGET_GOARCH}

# copy our sources into the builder image
COPY cloudflared/. /go/src/
WORKDIR /go/src/

# compile cloudflared
RUN make cloudflared

# use a distroless base image with glibc
FROM debian:latest

# copy our compiled binary
COPY --from=builder /go/src/cloudflared /usr/local/bin/

# command / entrypoint of container
ENTRYPOINT ["cloudflared", "--no-autoupdate"]
CMD ["version"]
