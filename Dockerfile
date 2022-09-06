FROM golang:1.18-alpine

ENV ETCD_HOME /etcd
ENV GOPATH /etcd/go
ENV GOBIN /etcd/bin

WORKDIR /etcd

RUN apk update && apk add vim git && wget https://storage.googleapis.com/etcd/v3.5.4/etcd-v3.5.4-linux-amd64.tar.gz  && \
mkdir bin && tar -xf etcd-v3.5.4-linux-amd64.tar.gz -C bin --strip-components 1 && \
rm -rf etcd-v3.5.4-linux-amd64.tar.gz && \
it clone --branch  v3.5.4 --depth 1 https://github.com/etcd-io/etcd src && \
cd src && go install -v ./tools/benchmark && \
ln -s /etcd/bin/benchmark /usr/bin/benchmark && \
ln -s /etcd/bin/etcd /usr/bin/etcd && \
ln -s /etcd/bin/etcdctl /usr/bin/etcdctl

EXPOSE 2379
EXPOSE 2380
