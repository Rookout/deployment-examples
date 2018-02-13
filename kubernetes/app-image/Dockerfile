FROM ubuntu

RUN apt-get update -y && apt-get install git python python-pip -y
ADD . / example/

RUN pip install -r example/requirements.txt

EXPOSE 8888

CMD ["python", "example/app.py"]
