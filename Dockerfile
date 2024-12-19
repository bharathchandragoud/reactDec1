#Step 1 : build react app

FROM node:alpine3.18 as build

WORKDIR /app

COPY package.json .

RUN npm install

COPY  . .

RUN npm run build

#step 2:  server with nginx

FROM nginx:1.23-alpine

WORKDIR /usr/share/nginx/html

RUN  rm -rf *

COPY --from=build /app/build .

EXPOSE 80

ENTRYPOINT [ "nginx", "-g", "demon off;" ]