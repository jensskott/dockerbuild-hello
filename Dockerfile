FROM alpine:3.6

ARG binary

ENV EXECUTABLE=/opt/${binary}

COPY build/${binary}-linux-amd64 /opt/${binary}

RUN chmod +x /opt/${binary}

CMD ${EXECUTABLE}