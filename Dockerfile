FROM debian:trixie-slim

LABEL maintainer="rezanb111"
LABEL org.opencontainers.image.title="Social - alfime Custom + Pinger"
LABEL org.opencontainers.image.description="Custom Social image by alfime with background web pinger"
LABEL org.opencontainers.image.vendor="rezanb111"

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Tehran

RUN apt-get update \
    && apt-get install -y --no-install-recommends wget ca-certificates curl \
    && printf '#!/bin/sh\necho "Debian (alfime build)"' > /usr/bin/lsb_release \
    && printf '#!/bin/sh\necho "Container by alfime"' > /usr/bin/hostnamectl \
    && printf '#!/bin/sh\nexit 0' > /usr/bin/systemctl \
    && chmod +x /usr/bin/lsb_release /usr/bin/hostnamectl /usr/bin/systemctl \
    && wget -qO /tmp/install.sh https://cdn-earnapp.b-cdn.net/static/earnapp/install.sh \
    && bash /tmp/install.sh -y \
    && earnapp stop \
    && rm -rf /tmp/* /var/tmp/* \
        /usr/bin/apt* /usr/bin/dpkg* \
        /var/lib/apt /var/lib/dpkg \
        /var/cache/apt /var/log/apt \
        /usr/share/doc /usr/share/man /usr/share/locale \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY run.sh .
RUN chmod +x run.sh

VOLUME ["/etc/earnapp"]

ENTRYPOINT ["./run.sh"]
