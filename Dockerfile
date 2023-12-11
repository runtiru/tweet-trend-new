FROM openjdk:8
LABEL organiser=tiru
ADD jarstaging/com/valaxy/demo-workshop/2.1.2/demo-workshop-2.1.2.jar titu.jar
CMD ["java" "-jar" "titu.jar"]
EXPOSE 8000