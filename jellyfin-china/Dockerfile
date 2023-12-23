FROM lscr.io/linuxserver/jellyfin

COPY append_hosts.sh /
RUN apt update &&\
    apt -y install dnsutils &&\
    apt clean &&\
    rm -rf /var/lib/apt/lists/*

RUN bash /append_hosts.sh &&\
    cat /etc/hosts
