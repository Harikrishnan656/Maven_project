FROM  maven:amazoncorretto AS builder

WORKDIR /Maven_project

COPY Maven_project/* .

RUN mvn install

FROM tomcat:9.0

COPY --from=builder /target/*.war /usr/local/tomcat/webapps/war.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
