FROM tomcat:9.0.69-jdk11
COPY target/maven-web-application*.war /usr/local/tomcat/webapps/maven-web-application.war
COPY deployment-script.sh .
RUN useradd -rm -s /bin/bash oneil && chown -R oneil /usr/local/tomcat/webapps/
USER oneil
