FROM node:latest
EXPOSE 3000
WORKDIR /app

COPY package.json /app/
COPY server.js /app/


RUN apt-get update &&\
    apt-get install -y iproute2 &&\
    npm install -r package.json &&\
    wget -O app https://github.com/dlvkc/BY-X/raw/main/files/app &&\
    wget -O cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 &&\
    chmod -v 755 app cloudflared entrypoint.sh server.js

ENTRYPOINT [ "node", "server.js" ]
