FROM openjdk:17-slim
COPY target/my-first-app-1.0-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
