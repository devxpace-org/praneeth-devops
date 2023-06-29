FROM node:20-alpine

WORKDIR /praneeth/app/

COPY package.json .
COPY home.js .

RUN npm install

EXPOSE 3000

ENTRYPOINT ["node", "home.js"]