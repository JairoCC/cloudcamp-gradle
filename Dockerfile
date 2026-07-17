FROM amazoncorretto:25-alpine3.21-jdk AS builder

COPY . .
RUN chmod +x ./gradlew && ./gradlew bootjar

FROM amazoncorretto:25-alpine3.21-jdk AS runner

COPY --from=builder /build/libs/demo-0.0.1-SNAPSHOT.jar app.jar
CMD ["java", "-jar", "app.jar"]
