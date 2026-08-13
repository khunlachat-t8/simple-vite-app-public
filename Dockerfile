# Layer1 : builder
FROM node:26 AS builder

WORKDIR /app

COPY package*json ./

RUN npm install

COPY . .

RUN npm run build

# Layer2 : server
FROM nginx:1.31-alpine3.24

WORKDIR /usr/share/nginx/html

RUN apk update && apk add --no-cache busybox-extras curl

COPY nginx.conf /etc/nginx/nginx.conf

COPY --from=builder /app/dist /app

EXPOSE 80
