# RMQTT

RMQTT 是一款开源、高性能、高可用的 MQTT 消息代理。

## 仓库来源

本应用配置来自：`https://github.com/60999/sc_appstore`

## 端口说明

| 端口 | 用途 | 说明 |
|------|------|------|
| 1883 | MQTT TCP | 标准 MQTT 协议端口 |
| 8883 | MQTT TLS | MQTT over TLS/SSL |
| 6060 | HTTP API | 管理接口 |
| 8083 | WebSocket | MQTT over WebSocket |

## 端口绑定配置

**重要**：如果需要从外部访问 MQTT 服务，请确保端口绑定到 `0.0.0.0` 而不是 `127.0.0.1`。

在 1Panel 中：
1. 进入 **容器** → 找到 RMQTT 容器
2. 编辑配置
3. 将端口绑定从 `127.0.0.1` 改为 `0.0.0.0`
4. 保存并重启容器

## 安全配置

### 禁止匿名访问

默认配置已禁用匿名访问：
```toml
listener.tcp.external.allow_anonymous = false
```

**重要**：如果空 JWT 可以连接成功，请检查：
1. JWT 公钥是否正确配置
2. `rmqtt-auth-jwt` 插件是否在 `plugins.default_startups` 列表中
3. JWT 配置文件路径是否正确

### JWT 认证配置

RMQTT 支持 JWT 认证。配置步骤：

1. **从 Casdoor 获取证书**：在 Casdoor 应用详情页复制证书内容
2. **填写 JWT 公钥**：在安装时将 Casdoor 应用的证书（PEM 格式）粘贴到「JWT 公钥/证书」字段
3. **验证配置**：确保以下配置正确

**注意**：只需填写 Casdoor 中应用对应的证书，即可完成 JWT 认证配置。

```toml
# 主配置文件中
plugins.default_startups = [
    "rmqtt-retainer",
    "rmqtt-http-api",
    "rmqtt-auth-jwt",
    "rmqtt-acl"
]

# JWT 认证配置
from = "password"
encrypt = "public-key"
public_key = "/app/rmqtt/data/jwt/jwt_cert.pem"
disconnect_if_expiry = true
validate_claims.exp = true
```

### 测试连接

使用 MQTT 客户端测试：
```bash
# 应该失败 - 无密码
mosquitto_pub -h localhost -p 1883 -t test -m "hello"

# 应该失败 - 空 JWT
mosquitto_pub -h localhost -p 1883 -t test -m "hello" -u "" -P ""

# 应该成功 - 有效 JWT
mosquitto_pub -h localhost -p 1883 -t test -m "hello" -u "username" -P "your_jwt_token"
```

## 官方文档

- https://github.com/rmqtt/rmqtt
- https://github.com/rmqtt/rmqtt/blob/master/docs/zh_CN/README.md
