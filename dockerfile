FROM amazoncorretto:17
WORKDIR /app
COPY ./target/spring-petclinic-3.3.0-SNAPSHOT.jar /app/petclinic.jar
ENTRYPOINT ["java","-jar","petclinic.jar"]