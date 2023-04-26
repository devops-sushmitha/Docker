ARG CENTOS_VERSION=latest
FROM centos:${CENTOS_VERSION}

LABEL maintainer="sushmitha.thula9@gmail.com"

ENV TOMCAT_VERSION=9.0.74

#Below 3 lines are for using yum in centos, centos using vault, and mirror needs to be changed to vault as below
RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum install java -y
RUN mkdir /opt/tomcat
WORKDIR /opt/tomcat
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.74/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz .
RUN tar -zxvf apache-tomcat-${TOMCAT_VERSION}.tar.gz
RUN mv apache-tomcat-${TOMCAT_VERSION}/* /opt/tomcat

#If we have webapp.war file we can copy it as below and use
#COPY ./webapp.war /opt/tomcat/webapps

VOLUME /opt/tomcat

EXPOSE 8080

#Tried using "run" in ENTRYPOINT, "start script" in CMD but throws error, so using both run and start script in CMD
CMD ["/opt/tomcat/bin/catalina.sh","run"]
