###### build stage ####
FROM golang:1.14-stretch as build

ARG ARCH

ENV GO111MODULE=on
ENV CGO_ENABLED=0
ENV GOOS=linux
ENV GOARCH=${ARCH}

WORKDIR /go/cache

WORKDIR /app

ADD go.mod .

RUN go mod download

ADD . .

RUN go build -ldflags "-s -w" -o ./dist/cacheproxy cmd/cacheproxy/main.go


FROM alpine:3.9

WORKDIR /app

COPY --from=build /app/dist/cacheproxy dist/cacheproxy

CMD ["/app/dist/cacheproxy"]
