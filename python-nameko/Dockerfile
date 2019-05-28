FROM python:2.7-stretch AS blah
RUN mkdir /nameko
WORKDIR /nameko
ADD requirements.txt /nameko
COPY rook-0.1.59.tar.gz .
#FROM blah AS blah2
RUN pip install /nameko/rook-0.1.59.tar.gz
RUN pip install -r /nameko/requirements.txt
ADD nameko_example.py /nameko/

