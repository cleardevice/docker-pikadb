FROM ubuntu:20.04
MAINTAINER cd <cleardevice@gmail.com>

RUN apt-get update  && \
    apt-get install -y nano libgoogle-glog-dev libsnappy-dev libprotobuf-dev protobuf-compiler libbz2-dev zlib1g-dev liblz4-dev libzstd-dev libgflags-dev git make g++ && \
\
    git clone https://github.com/Qihoo360/pika.git /tmp/code --depth 1 && \
    cd /tmp/code && \
    make DISABLE_WARNING_AS_ERROR=1 && \
    mv /tmp/code/output /pika && \
\
    apt-get remove --purge -y git make g++ && \
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /pika
EXPOSE 9221

ENTRYPOINT ["/pika/entrypoint.sh"]
CMD ["/pika/bin/pika", "-c", "/pika/conf/pika.conf"]
