# buildTime
FROM golang:1.8.3-alpine AS build-env
ADD . /src
WORKDIR /src
ENV GOPATH /src
RUN apk update && apk upgrade && \
    apk add --no-cache git
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -a -installsuffix cgo -o ./bin/helloworld .

# runTime
FROM alpine
COPY --from=build-env src/bin/helloworld /app/
RUN apk update && apk upgrade && \
    apk add --no-cache ca-certificates
WORKDIR /app/
ENTRYPOINT ["./helloworld"]
