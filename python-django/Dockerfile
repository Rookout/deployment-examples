FROM python:3.7-stretch
ADD requirements.txt .
RUN pip install -r requirements.txt
ADD . .
RUN python manage.py migrate