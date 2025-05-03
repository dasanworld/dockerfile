FROM node:12-alpine

WORKDIR /app
COPY *.json ./
COPY *.js ./

COPY ./bin ./bin/
COPY ./public ./public/
COPY ./routes ./routes/
COPY ./views ./views/

RUN chown -Rf node:node .

USER node
EXPOSE 3000
RUN npm ci --only=production
ENTRYPOINT [ "npm", "start" ]


FROM n8nio/n8n:latest

USER root

RUN apt-get update && apt-get install -y \
    sudo curl vim \
    && rm -rf /var/lib/apt/lists/*

USER node
