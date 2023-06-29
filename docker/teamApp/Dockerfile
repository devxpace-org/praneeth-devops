FROM node:20-alpine

WORKDIR /praneeth/app/

COPY package.json .
COPY shahab.js .

RUN npm install

EXPOSE 3000

ENTRYPOINT ["node", "shahab.js"]