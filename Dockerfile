FROM gradle:9.5.1-jdk25-alpine AS builder
WORKDIR /app
COPY . .
RUN gradle bootjar

FROM amazoncorretto:25-alpine3.21-jdk AS runner

COPY --from=builder /app/build/libs/demo-0.0.1-SNAPSHOT.jar app.jar
CMD ["java", "-jar", "app.jar"]
