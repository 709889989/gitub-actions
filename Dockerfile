FROM golang:1.16 AS builder
ARG VERSION=0.0.10
WORKDIR /go/src/app
COPY calc.go .
RUN go build -o main -ldflags="-X 'main.version=${VERSION}'" calc.go

FROM debian:stable-slim
COPY --from=builder /go/src/app/main /go/bin/main
ENV PATH="/go/bin:${PATH}"
CMD ["main"]