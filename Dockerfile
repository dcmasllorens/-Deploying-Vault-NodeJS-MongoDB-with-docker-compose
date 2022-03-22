FROM bitnami/git:2.35.1-debian-10-r48 as gitDocker

WORKDIR /app

RUN git clone https://github.com/Cybersecurity-Montilivi/Using-ExpressJS-with-Docker-MongoDB

FROM node:14.7

WORKDIR /appnode

COPY --from=gitDocker /app/Deploying-NodeJS-MongoDB-with-docker-compose ./

RUN npm install -g yarn

RUN yarn install

CMD [ "node", "app.js" ]