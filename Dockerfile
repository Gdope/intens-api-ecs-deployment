FROM maven:3.8.6-eclipse-temurin-8 AS build_image
WORKDIR /usr/src/intens-api
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests



FROM eclipse-temurin:8-jre
LABEL Project="stefan-intens"
WORKDIR /opt/intens-api
COPY --from=build_image /usr/src/intens-api/target/*.jar intens-api.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "intens-api.jar"]