FROM amazoncorretto:17
WORKDIR /app
COPY ./target/spring-petclinic-*.jar /app/petclinic.jar
ENTRYPOINT ["java","-jar","petclinic.jar"]
