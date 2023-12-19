FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
  iputils \
  traceroute \
  net-tools \
  arp-scan \
  dnsutils \
  curl \
  wget \
  telnet \
  tcpdump \
  nmap \
  netcat \
  iproute2 \
  iptables \
  ipset \
  iptraf \
  iperf \
  iperf3 \
  iftop \
  ethtool \
  bridge-utils \
  arping \
  dnsutils \
  apache2-utils \
  openssh-server \
  ufw \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && echo "root:root" | chpasswd

COPY ./01-sshd.conf /etc/ssh/sshd_config.d/01-sshd.conf

COPY ./entrypoint.sh /entrypoint.sh

EXPOSE 22

ENTRYPOINT ./entrypoint.sh /entrypoint.sh
