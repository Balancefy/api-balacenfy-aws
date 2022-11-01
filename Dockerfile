FROM maven:3.8.4-jdk-11 AS build
WORKDIR /app
COPY src /app/src
COPY pom.xml /app
RUN mvn -f /app/pom.xml package -Dmaven.test.skip=true

FROM openjdk:11-jre-slim
COPY --from=build /app/target/*.jar /usr/local/lib/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/app.jar"]