FROM node:12.22.7

COPY . .
RUN mkdir -p /dist
RUN npm ci
RUN npm run build
