FROM debian as builder

WORKDIR /
COPY append_hosts.sh /
RUN apt update && apt -y install dnsutils
RUN bash /append_hosts.sh

FROM lscr.io/linuxserver/jellyfin
COPY --from=builder /etc/hosts /etc/hosts

