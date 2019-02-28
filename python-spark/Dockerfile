FROM python:2.7.15-stretch
RUN mkdir /app
RUN apt-get update
RUN apt-get install -y software-properties-common
RUN apt-add-repository ppa:webupd8team/java
RUN apt-get update
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | \
  debconf-set-selections
RUN echo debconf shared/accepted-oracle-license-v1-1 seen true | \
  debconf-set-selections
RUN apt-get install --allow-unauthenticated -y oracle-java8-installer
RUN mkdir /opt/scala
RUN curl -LJO http://downloads.lightbend.com/scala/2.12.1/scala-2.12.1.deb
RUN dpkg -i scala-2.12.1.deb
RUN curl -LJO "https://www.apache.org/dyn/mirrors/mirrors.cgi?action=download&filename=spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz"
RUN tar -xvf spark-2.4.0-bin-hadoop2.7.tgz
RUN mkdir /opt/spark
RUN mv -v spark-2.4.0-bin-hadoop2.7/* /opt/spark/
RUN pip install six
ADD example.py /app
WORKDIR /app
ENV PATH $PATH:/opt/spark/bin/