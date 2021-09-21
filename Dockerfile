FROM openjdk:8-jdk-alpine
VOLUME /tmp
ARG JAVA_OPTS
ENV JAVA_OPTS=$JAVA_OPTS
COPY target/react-and-spring-data-rest-0.0.1-SNAPSHOT.jar reactandspringdatarest.jar
ENTRYPOINT exec java $JAVA_OPTS -jar reactandspringdatarest.jar
# For Spring-Boot project, use the entrypoint below to reduce Tomcat startup time.
#ENTRYPOINT exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar reactandspringdatarest.jar
