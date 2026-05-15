FROM  maven:amazoncorretto AS builder

WORKDIR /Maven

COPY * .

RUN mvn install

FROM tomcat:9.0

COPY --from=builder /target/*.war /usr/local/tomcat/webapps/webapp.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
