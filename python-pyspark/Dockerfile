FROM datamechanics/spark:3.2.1-latest
USER root
RUN sed -i 's/deb /deb \[trusted=yes\] /' /etc/apt/sources.list
RUN apt-get update || true
RUN apt-get install -y gcc python3-dev
ADD requirements.txt .
RUN pip install -r requirements.txt
ADD pyspark_demo.py .
ADD driver.py .