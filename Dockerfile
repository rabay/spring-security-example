# Use the official OpenJDK 17 image as the base image
FROM amazoncorretto:17-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the Maven project files to the container
COPY target/login.jar ./app.jar

# Set the entry point to run the Spring Boot application
ENTRYPOINT ["java", "-jar", "./app.jar"]