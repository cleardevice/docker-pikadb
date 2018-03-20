FROM ubuntu:16.04 as builder
RUN apt-get update && \
    apt-get install -y libgoogle-glog0v5 libsnappy-dev libgoogle-glog-dev libgflags-dev libprotobuf-dev git make g++ && \
    git clone https://github.com/Qihoo360/pika.git /tmp/code --depth 1 && \
    make -C /tmp/code

FROM ubuntu:16.04
MAINTAINER cd <cleardevice@gmail.com>

RUN apt-get update && \
    apt-get install -y nano libgoogle-glog0v5 libsnappy-dev && \

    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /tmp/* /var/tmp/* && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /tmp/code/output /pika

WORKDIR /pika
EXPOSE 9221

CMD /pika/bin/pika -c /pika/conf/pika.conf
