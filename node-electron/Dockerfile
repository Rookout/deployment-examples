FROM node:10.14
ADD package.json .
RUN apt-get update
RUN apt-get -y install libgtkextra-dev libgconf2-dev libnss3 libasound2 libxtst-dev libxss1
RUN npm install --save-dev electron
RUN npm install
ADD electron_main.js electron_main.js
ADD index.html index.html
