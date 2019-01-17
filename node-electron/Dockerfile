FROM node:10.14

ADD package.json .

#Installing electron
RUN apt-get update && \
  apt-get install -y xvfb x11-xkb-utils xfonts-100dpi xfonts-75dpi \
  xfonts-scalable xfonts-cyrillic x11-apps clang libdbus-1-dev libgtk2.0-dev \
  libnotify-dev libgnome-keyring-dev libgconf2-dev libasound2-dev libcap-dev \
  libcups2-dev libxtst-dev libxss1 libnss3-dev gcc-multilib g++-multilib

RUN npm install --save rookout --runtime=electron --target=4.0.1

RUN npm install electron --save-dev

ADD electron_main.js electron_main.js

ADD index.html index.html
