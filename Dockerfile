FROM golang:1.11-alpine as base
RUN apk add --no-cache libstdc++ gcc g++ make git ca-certificates linux-headers
#MAINTAINER "Energi Support"
WORKDIR /go/src/github.com/energi/nrgexporter
ADD . .
RUN go get && go install

FROM alpine:latest
#MAINTAINER "Energi Support"
RUN apk add --no-cache jq ca-certificates linux-headers
COPY --from=base /go/bin/nrgexporter /usr/local/bin/nrgexporter
ENV GETH https://mainnet.infura.io/v3/f5951d9239964e62aa32ca40bad376a6
ENV ADDRESSES ""
ENV DELAY 500

EXPOSE 9090
ENTRYPOINT nrgexporter
