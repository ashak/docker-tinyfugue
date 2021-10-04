FROM debian:bullseye as builder

RUN apt-get update \
 && apt-get -y install build-essential git libicu-dev

RUN git clone https://github.com/ingwarsw/tinyfugue.git \
 && cd tinyfugue \
 && apt-get install -y libgnutls28-dev libncurses5-dev libpcre3-dev zlib1g-dev \
 && ./configure \
 && make \
 && make install

FROM debian:bullseye-slim
COPY --from=builder /usr/local/share/tf-lib /usr/local/share/tf-lib
COPY --from=builder /usr/local/bin/tf /usr/local/bin/tf5
CMD ["/usr/local/bin/tf5"]
