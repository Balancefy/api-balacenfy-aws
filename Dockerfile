FROM maven:3.8.4-jdk-11 AS build
COPY src /root/docker-api/api-balancefy-aws/src
COPY pom.xml /root/docker-api/api-balancefy-aws
RUN mvn -f /root/docker-api/api-balancefy-aws/pom.xml package -Dmaven.test.skip=true

FROM openjdk:11-jre-slim
COPY --from=build /root/docker-api/api-balancefy-aws/target/*.jar /usr/local/lib/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/app.jar"]