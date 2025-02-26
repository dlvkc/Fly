FROM node:latest
EXPOSE 3000
WORKDIR /app

COPY package.json /app/
COPY server.js /app/


RUN apt-get update &&\
    apt-get install -y iproute2 &&\
    npm install -r package.json &&\
    wget -O cloud https://github.com/dlvkc/BY-X/raw/main/files/cloud &&\
    wget -O cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 &&\
    chmod -v 755 cloud cloudflared entrypoint.sh server.js

ENTRYPOINT [ "node", "server.js" ]
