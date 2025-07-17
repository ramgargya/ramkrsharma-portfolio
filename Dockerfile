# Stage 1: Build the JAR using Maven
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Run the app using OpenJDK
FROM openjdk:21-jdk-slim
WORKDIR /app
COPY --from=build /app/target/portfolio-0.0.1-SNAPSHOT.jar portfolio.jar
EXPOSE 9090
ENTRYPOINT ["java", "-jar", "portfolio.jar"]
