FROM maven:3.8.8-eclipse-temurin-8 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
COPY WebContent ./WebContent
COPY Config.properties ./WebContent/Config.properties
RUN mvn package -DskipTests

FROM tomcat:9.0-jdk8-temurin
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
WORKDIR /usr/local/tomcat/webapps
