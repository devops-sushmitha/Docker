ARG CENTOS_VERSION=latest
FROM centos:${VERSION}

LABEL maintainer="sushmitha.thula9@gmail.com"

ENV TOMCAT_VERSION=9.0.73

RUN yum install java -y
RUN mkdir /opt/tomcat
WORKDIR /opt/tomcat
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.73/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz .
RUN tar -zxvf apache-tomcat-${TOMCAT_VERSION}.tar.gz
RUN mv apache-tomcat-${TOMCAT_VERSION}/* /opt/tomcat
COPY ./webapp.war /opt/tomcat/webapps

VOLUME /opt/tomcat

EXPOSE 8080

ENTRYPOINT ["run"]
CMD ["/opt/tomcat/bin/catalina.sh"]
