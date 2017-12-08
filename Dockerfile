FROM alpine:3.6

ARG binary

COPY build/${binary}-linux-amd64 /opt/${binary}