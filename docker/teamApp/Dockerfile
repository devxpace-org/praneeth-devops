FROM node:20-alpine

WORKDIR /praneeth/app/

COPY package.json .
COPY harshitha.js .

RUN npm install

EXPOSE 3000

ENTRYPOINT ["node", "harshitha.js"]