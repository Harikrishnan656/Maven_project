FROM amazoncorretto:21-alpine

WORKDIR /Maven_project/

COPY * .

RUN mvn install

FROM tomcat:9.0

COPY --from=builder /target/*.war /usr/local/tomcat/webapps/war.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
