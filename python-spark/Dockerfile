FROM openjdk:8u212-jdk-stretch
RUN mkdir /app
RUN apt-get update && apt-get install python-pip -y
RUN mkdir /opt/scala
RUN curl -LJO http://downloads.lightbend.com/scala/2.12.1/scala-2.12.1.deb
RUN apt install -y ./scala-2.12.1.deb
RUN curl -LJO "https://www.apache.org/dyn/mirrors/mirrors.cgi?action=download&filename=spark/spark-2.4.3/spark-2.4.3-bin-hadoop2.7.tgz"
RUN tar -xvf spark-2.4.3-bin-hadoop2.7.tgz
RUN mkdir /opt/spark
RUN mv -v spark-2.4.3-bin-hadoop2.7/* /opt/spark/
RUN pip install six
ADD example.py /app
ADD example_executor_module.py /app
WORKDIR /app
ENV PATH $PATH:/opt/spark/bin/
