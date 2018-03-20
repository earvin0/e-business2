FROM debian:stretch-slim

RUN apt-get update

RUN apt-get install -y software-properties-common apt-transport-https apt-utils 
RUN apt-get update && apt-get install -my wget gnupg

RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
RUN add-apt-repository -y ppa:webupd8team/java 

RUN apt-get update
RUN mkdir -p /usr/share/man/man1
RUN apt-get install -y --allow-unauthenticated oracle-java8-installer
RUN apt-get install oracle-java8-installer
RUN apt-get install -y scala sbt
RUN apt-get install -y mysql-server
RUN apt-get install -y mysql-client

EXPOSE 9000

WORKDIR /home/
RUN git clone https://github.com/playframework/play-scala-slick-example
WORKDIR /home/play-scala-slick-example/
CMD sbt run
