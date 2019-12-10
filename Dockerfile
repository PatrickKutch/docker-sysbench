# VERSION 1.0

FROM ubuntu:18.04
RUN apt-get update && apt-get install -y curl
# grab the latest sysbench per https://linuxtechlab.com/benchmark-linux-systems-install-sysbench-tool/
RUN  curl -s https://packagecloud.io/install/repositories/akopytov/sysbench/script.deb.sh | bash

WORKDIR /root
RUN apt-get -y install sysbench python


WORKDIR /root
COPY run.sh .
ENTRYPOINT ["./run.sh"]
