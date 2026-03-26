FROM ubuntu:24.04 AS build
RUN <<EOF
    set -eu
    apt-get update
    apt-get install -y --no-install-recommends gcc libc6-dev make libssl-dev zlib1g-dev curl ca-certificates
    rm -rf /var/lib/apt/lists/*
EOF
WORKDIR /src
RUN <<EOF
    set -eu
    curl -sfL https://github.com/TelegramMessenger/MTProxy/archive/cafc3380a81671579ce366d0594b9a8e450827e9.tar.gz -o src.tar.gz
    echo "0103d5aef46191e276666d0f1eaf83d49eb260f59dad831fb703e1ee8ee6d94f  src.tar.gz" | sha256sum -c
    tar xzf src.tar.gz --strip-components=1
    rm src.tar.gz
EOF
RUN make

FROM ubuntu:24.04
RUN <<EOF
    set -eu
    apt-get update
    apt-get install -y --no-install-recommends libssl3t64 zlib1g curl ca-certificates
    rm -rf /var/lib/apt/lists/*
EOF
COPY --from=build /src/objs/bin/mtproto-proxy /usr/local/bin/
RUN mkdir /data
COPY --chmod=755 entrypoint /usr/local/bin/
ENTRYPOINT ["entrypoint"]
