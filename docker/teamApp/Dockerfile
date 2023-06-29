FROM node:20-alpine

WORKDIR /praneeth/app/

COPY package.json .
COPY maazin.js .

RUN npm install

EXPOSE 3000

ENTRYPOINT ["node", "maazin.js"]