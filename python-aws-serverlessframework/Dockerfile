FROM node:8.10.0

RUN npm install -g serverless

WORKDIR /app

RUN npm install

COPY . .

RUN sls plugin install -n serverless-python-requirements

RUN sed -i '26s/.*/      "ROOKOUT_TOKEN": "$ROOKOUT_TOKEN"/' serverless.yml
