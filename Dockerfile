FROM debian

ENV VERSION 1.5.8

RUN apt-get update && \
    apt-get install -y wget unzip && \
    mkdir -p /sia && \
    wget -O /tmp/sia.zip https://sia.tech/releases/Sia-v${VERSION}-linux-amd64.zip && \
    unzip -d /tmp/sia/ /tmp/sia.zip && \
    mv /tmp/sia/Sia-v${VERSION}-linux-amd64/siac /usr/local/bin/ && \
    mv /tmp/sia/Sia-v${VERSION}-linux-amd64/siad /usr/local/bin/ && \
    rm -rf /tmp/sia/ /tmp/sia.zip /var/lib/apt/lists

WORKDIR /sia
EXPOSE 9981 9982 9983 9984

# bind api port to all interfaces in case we want to use it, we don't expose it by default.
CMD ["/usr/local/bin/siad","--api-addr=0.0.0.0:9980","--disable-api-security"]
