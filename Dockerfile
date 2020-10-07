FROM node:14.13.0-alpine3.12 AS multistage

RUN apk add --no-cache --update git

RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app

WORKDIR /home/node/app

COPY package*.json ./

USER node

RUN npm install

COPY --chown=node:node . .
##

FROM node:14.13.0-alpine3.12

COPY --from=multistage /home/node/app /home/node/

EXPOSE 1337

CMD [ "node", "app.js" ]