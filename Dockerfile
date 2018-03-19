FROM ubuntu:16.04
MAINTAINER cd <cleardevice@gmail.com>

ENV PIKA_VERSION=2.3.2

RUN apt-get update && \
    apt-get install -y nano libsnappy-dev libgoogle-glog-dev libgflags-dev libprotobuf-dev git make g++ curl && \

    curl -Ls https://github.com/Qihoo360/pika/releases/download/v${PIKA_VERSION}/pika-linux-x86_64-v${PIKA_VERSION}.tar.bz2 | tar -xj -C /tmp
    cd /tmp/pika* && \
    make && \
    mv /tmp/pika*/output /pika && \

    apt-get remove --purge -y libgflags-dev libprotobuf-dev git make g++ && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /pika
EXPOSE 9221

CMD /pika/bin/pika -c /pika/conf/pika.conf
