FROM golang:1.10.0-alpine3.7 as builder
WORKDIR /app
#RUN go get -d -v golang.org/x/net/html
RUN apk add --update --no-cache alpine-sdk bash ca-certificates \
      libressl \
      tar \
      git openssh openssl yajl-dev zlib-dev cyrus-sasl-dev openssl-dev build-base coreutils
RUN git clone https://github.com/edenhill/librdkafka.git
WORKDIR /app/librdkafka
RUN ./configure --prefix /usr \
&& make \
&& make install
WORKDIR /app
RUN go get -d -v github.com/gorilla/mux \
&& go get -u github.com/confluentinc/confluent-kafka-go/kafka \
&& go get -d -v golang.org/x/net/html
COPY kafka.go .
RUN GOOS=linux go build -a -installsuffix cgo -o kafka .

FROM alpine:latest
RUN apk add --update --no-cache bash ca-certificates \
      libressl zlib-dev cyrus-sasl-dev \
openssl-dev \
build-base
WORKDIR /app
COPY --from=builder /app .
COPY etc/docker/demo.key .
COPY etc/docker/demo.pem .
COPY etc/docker/casnakeoil-ca-1.crt .
RUN chmod 644 demo.key demo.pem casnakeoil-ca-1.crt
WORKDIR /app/librdkafka
RUN ./configure --prefix /usr \
&& make \
&& make install
RUN apk del build-base bash ca-certificates libressl zlib-dev openssl-dev
WORKDIR /app
CMD ["./kafka"]