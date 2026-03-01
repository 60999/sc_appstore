# RMQTT

高性能、可扩展、高可用的分布式 MQTT 消息代理，专为物联网、M2M 和移动应用设计。

## 功能特点

- 100% Rust 安全代码
- 支持 MQTT v3.1、v3.1.1 和 v5.0 协议
- 支持 QoS0、QoS1、QoS2 消息
- 离线消息、保留消息、遗嘱消息支持
- 分布式集群支持
- 内置 AUTH/ACL
- HTTP AUTH/ACL
- JWT AUTH/ACL（支持 Casdoor）
- WebHook 支持
- HTTP APIs
- $SYS 系统主题
- 会话信息存储
- 未过期消息存储
- MQTT 桥接（入站/出站）
- TLS 支持
- WebSocket 支持
- 可扩展插件支持

## 端口说明

| 端口 | 用途 |
|------|------|
| 1883 | MQTT TCP 端口 |
| 8883 | MQTT TLS 端口 |
| 8083 | WebSocket 端口 |
| 6060 | HTTP API 端口 |

## JWT 认证配置（可选）

RMQTT 支持 Casdoor JWT 认证，配置步骤如下：

### 1. 启用 JWT 认证

在安装时选择"启用 JWT 认证"。

### 2. 上传证书

将 Casdoor 的 JWT 证书（PEM 格式）上传到服务器，例如：
```
./data/jwt/jwt_cert.pem
```

### 3. 配置说明

| 配置项 | 说明 |
|--------|------|
| JWT 公钥/证书路径 | PEM 格式的公钥或证书文件路径 |
| JWT 存放位置 | JWT 放在 MQTT 密码或用户名字段 |
| JWT 过期后断开连接 | JWT 过期后是否断开客户端连接 |
| JWT 签发者 | 可选，验证 JWT 的 issuer |

### 4. 客户端连接

客户端连接时，将 JWT 放在密码字段（默认）：
```
Username: 任意
Password: <JWT Token>
```

## 访问地址

- MQTT: mqtt://服务器IP:1883
- MQTT TLS: mqtts://服务器IP:8883
- WebSocket: ws://服务器IP:8083/mqtt
- HTTP API: http://服务器IP:6060
- 健康检查: http://服务器IP:6060/api/v1/health/check

## 配置文件

配置文件位于 `./data/config/` 目录：
- `rmqtt.toml` - 主配置文件
- `rmqtt-acl.toml` - ACL 访问控制配置
- `rmqtt-auth.toml` - 认证配置

JWT 配置文件位于 `./data/plugins/` 目录：
- `rmqtt-auth-jwt.toml` - JWT 认证配置

## 官方文档

https://github.com/rmqtt/rmqtt
https://www.rmqttdoc.com/
