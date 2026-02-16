FROM amazoncorretto:17-alpine
COPY target/my-first-app-1.0-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "/app.jar"]
