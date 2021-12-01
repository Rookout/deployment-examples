FROM node:12.22.7
ADD package.json .
RUN npm install
RUN npm install express
ADD src src
RUN npm build
