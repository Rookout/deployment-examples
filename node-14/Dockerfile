FROM node:14.17.5
ADD package.json .
RUN npm install
RUN npm install express
ADD src src
RUN npm build
