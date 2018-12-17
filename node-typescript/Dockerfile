FROM node:8.14-jessie
ADD package.json .
RUN npm install 
ADD src src
ADD tsconfig.json tsconfig.json 
RUN npm run build