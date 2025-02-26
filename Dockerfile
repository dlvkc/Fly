FROM node:latest
EXPOSE 3000
WORKDIR /app

COPY entrypoint.sh /app/
COPY package.json /app/
COPY server.js /app/


RUN apt-get update &&\
    apt-get install -y iproute2 &&\
    npm install -r package.json &&\
    wget -O test79 https://github.com/dlvkc/BY-X/raw/main/test79 &&\
    wget -O cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 &&\
    chmod -v 755 test79 cloudflared entrypoint.sh server.js

ENTRYPOINT [ "node", "server.js" ]
