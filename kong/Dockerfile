FROM kong:3.9.3

COPY infra/kong/grpc.lua \
    /usr/local/share/lua/5.1/kong/tools/grpc.lua

COPY infra/kong/kong.yaml \
    /etc/kong/kong.yaml

COPY shared-go-proto/base \
    /etc/kong/protos/base

COPY shared-go-proto/third_party/googleapis/google \
    /etc/kong/protos/google