FROM python:3.7-stretch
RUN mkdir /nameko
WORKDIR /nameko
ADD requirements.txt /nameko
RUN pip install -r /nameko/requirements.txt
ADD nameko_example.py /nameko/

