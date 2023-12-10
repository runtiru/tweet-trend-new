FROM openjdk:8
LABEL organiser=tiru
ADD jarstaging/com/valaxy/demo-workshop/2.1.2/demo-workshop-2.1.2.jar titu.jar
ENTRYPOINT ["java" "-jar" "titu.jar"]
