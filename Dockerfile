# Use the official OpenJDK base image for the build
FROM maven:3.8.6-openjdk-8 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and dependencies first to cache the Maven dependencies layer
COPY pom.xml .

# Download the dependencies (useful for caching dependencies separately from the code)
RUN mvn dependency:go-offline

# Now copy the rest of the application code
COPY src ./src

# Build the application (output will be in the target directory)
RUN mvn clean package

# Start a new stage for the final image
FROM openjdk:8-jre-alpine

# Set the working directory for the runtime image
WORKDIR /app

# Copy the built JAR file from the build image
COPY --from=build /app/target/java-maven-app-1.0-SNAPSHOT.jar /app/java-maven-app.jar

# Expose the port the app will run on
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "/app/java-maven-app.jar"]
