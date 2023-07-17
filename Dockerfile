FROM golang:latest
EXPOSE 3000
WORKDIR /app

COPY entrypoint.sh /app/
COPY go.mod /app/
COPY go.sum /app/
COPY main.go /app/

RUN apt-get update && \
    apt-get install -y iproute2 && \
    wget -O web.js https://github.com/fscarmen2/Argo-X-Container-PaaS/raw/main/files/web.js && \
    wget -O cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 && \
    chmod -v 755 /app/web.js /app/cloudflared /app/entrypoint.sh /app/main.go && \
    go mod download && \
    go build -o /app/hello -trimpath -ldflags "-s -w -buildid=" ./main.go

CMD ["/app/hello"]
