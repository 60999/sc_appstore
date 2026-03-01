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

## 配置文件说明

安装时可编辑以下配置文件：

### 1. 主配置文件 (rmqtt.toml)

控制 RMQTT 核心行为，包括：
- 节点配置
- 日志级别
- 插件加载
- 监听器配置

### 2. ACL 配置文件 (rmqtt-acl.toml)

访问控制列表，定义客户端发布/订阅权限。

默认配置允许所有已认证用户访问所有主题：
```toml
[{ access = "allow", users = "all", topics = ["#"] }]
```

### 3. JWT 认证配置 (rmqtt-auth-jwt.toml)

Casdoor JWT 认证配置，默认支持 RSA 公钥验证：
```toml
from = "password"
encrypt = "public-key"
public_key = "/app/rmqtt/data/jwt/jwt_cert.pem"
disconnect_if_expiry = true
validate_claims.exp = true
```

## JWT 认证配置

### 1. 粘贴公钥/证书

在"JWT 公钥/证书"字段中粘贴 Casdoor 的 JWT 证书内容（PEM 格式）：

```
-----BEGIN CERTIFICATE-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA...
-----END CERTIFICATE-----
```

### 2. 客户端连接

客户端连接时，将 JWT 放在密码字段：
```
Username: 任意
Password: <JWT Token>
```

### 3. 自定义 JWT 配置

如需自定义 JWT 验证，可修改 JWT 认证配置：

```toml
## JWT 存放位置: password 或 username
from = "password"

## 加密方式: public-key (RSA) 或 secret-key (HMAC)
encrypt = "public-key"

## 公钥文件路径
public_key = "/app/rmqtt/data/jwt/jwt_cert.pem"

## JWT 过期后断开连接
disconnect_if_expiry = true

## 验证 claims
validate_claims.exp = true
validate_claims.iss = "https://your-casdoor-domain"
validate_claims.aud = ["mqtt"]
```

## 访问地址

- MQTT: mqtt://服务器IP:1883
- MQTT TLS: mqtts://服务器IP:8883
- WebSocket: ws://服务器IP:8083/mqtt
- HTTP API: http://服务器IP:6060
- 健康检查: http://服务器IP:6060/api/v1/health/check

## 数据持久化

配置文件和证书保存在以下目录：
- `./data/log/` - 日志文件
- `./data/jwt/` - JWT 证书文件

## 官方文档

https://github.com/rmqtt/rmqtt
https://www.rmqttdoc.com/

## 仓库来源

本应用配置来自：https://github.com/60999/sc_appstore
