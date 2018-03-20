FROM ubuntu:16.04
MAINTAINER cd <cleardevice@gmail.com>

ENV PIKA_VERSION=2.3.2

RUN apt-get update && \
    apt-get install -y nano libgoogle-glog-dev libsnappy-dev git make g++ && \
# libprotobuf-dev

    git clone https://github.com/Qihoo360/pika.git /tmp/code && \
    cd /tmp/code && git checkout v${PIKA_VERSION} && \
    make && \
    mv /tmp/code/output /pika && \

    apt-get remove --purge -y git make g++ && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /pika
EXPOSE 9221

CMD /pika/bin/pika -c /pika/conf/pika.conf
