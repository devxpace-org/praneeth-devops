FROM node:20-alpine

WORKDIR /praneeth/app/

COPY package.json .
COPY tejaswini.js .

RUN npm install

EXPOSE 3000

ENTRYPOINT ["node", "tejaswini.js"]