# 基础镜像
FROM openjdk:8-jdk-alpine

# 指定工作目录
WORKDIR /app

# 将 jar 包添加到工作目录，比如 target/yuoj-backend-user-service-0.0.1-SNAPSHOT.jar
ADD target/api-interface-1.0-SNAPSHOT.jar .

# 暴露端口
EXPOSE 8123

# 启动命令
ENTRYPOINT ["java","-jar","/app/api-interface-1.0-SNAPSHOT.jar","--spring.profiles.active=prod"]