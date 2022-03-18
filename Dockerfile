FROM bitnami/git:2.35.1-debian-10-r48 as gitDocker

WORKDIR /app

RUN git clone https://github.com/dcmasllorens/Deploying-NodeJS-MongoDB-with-docker-compose.git

FROM node:14.7

WORKDIR /appnode

COPY --from=gitDocker /app/Deploying-NodeJS-MongoDB-with-docker-compose ./

RUN npm install

CMD [ "node", "app.js" ]