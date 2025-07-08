# 第一阶段：使用 Maven 构建应用
FROM maven:3.8.5-openjdk-11-slim AS builder

# 设置工作目录
WORKDIR /app

# 复制所有项目文件（包括 pom.xml 和 src）
COPY . .

# 使用 Maven 打包应用，跳过测试以提高构建速度
RUN mvn clean package -DskipTests

# 第二阶段：使用 JRE 运行应用
FROM openjdk:11-jre-slim

# 设置工作目录
WORKDIR /app

# 从构建阶段复制构建好的 jar 文件
COPY --from=builder /app/target/*.jar app.jar

# 声明运行端口
EXPOSE 8080

# 启动 Spring Boot 应用
CMD ["java", "-jar", "app.jar"]
