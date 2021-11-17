FROM node:12.22.7
ADD package.json .
RUN npm install
RUN npm install express
ADD src src
ADD tsconfig.json tsconfig.json 
RUN npm run build