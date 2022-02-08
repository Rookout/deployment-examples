FROM node:12.5

COPY . .
RUN npm install webpack webpack-dev-server --save-dev
RUN mkdir -p /dist
RUN npm install --only=prod
RUN npm run build
