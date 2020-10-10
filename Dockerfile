FROM node:14.13.0-alpine3.12 AS multistage

RUN apk add --no-cache --update git

WORKDIR /home/node/app

COPY package*.json ./

RUN npm install && npm audit fix 

COPY . ./
##

FROM node:14.13.0-alpine3.12

WORKDIR /breakroom

COPY --from=multistage /home/node/app /breakroom/

EXPOSE 1337

CMD [ "npm", "start" ]