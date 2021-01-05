FROM node:10

COPY . .
RUN mkdir -p /dist
RUN npm ci
RUN npm run build
