FROM python:2.7.15-alpine

EXPOSE 5000

RUN echo "https://mirror.csclub.uwaterloo.ca/alpine/v3.7/main" >/etc/apk/repositories
RUN echo "https://mirror.csclub.uwaterloo.ca/alpine/v3.7/community" >>/etc/apk/repositories

RUN apk update && apk add g++ make

WORKDIR /app
ADD requirements.txt .
RUN pip install -r requirements.txt

# move relevant files
ADD flask_rookout.py .

ENV ROOKOUT_AGENT_HOST=cloud.agent.rookout.com
ENV ROOKOUT_AGENT_PORT=443
ENV ROOKOUT_TOKEN=YOUR_TOKEN

CMD ["python", "flask_rookout.py"]




