# RMQTT

RMQTT 是一款开源、高性能、高可用的 MQTT 消息代理。

## 仓库来源

本应用配置来自：`https://github.com/60999/sc_appstore`

## 端口说明

| 端口 | 用途 | 说明 |
|------|------|------|
| 1883 | MQTT TCP | 标准 MQTT 协议端口 |
| 8883 | MQTT TLS | MQTT over TLS/SSL |
| 8083 | WebSocket | MQTT over WebSocket |
| 6060 | HTTP API | 管理接口 |
| 5363 | RPC | 集群 RPC 通信端口 |
| 6003 | Raft | 集群 Raft 共识端口 |
| 11883 | Internal MQTT | 内部 MQTT 通信端口 |

## 配置文件说明

应用使用配置文件挂载方式，配置文件位于 `data/` 目录：

```
data/
├── rmqtt.toml                      # 主配置文件
├── jwt_cert.pem                    # Casdoor JWT 证书
├── log/                            # 日志目录
├── cache/                          # 缓存目录
└── rmqtt-plugins/
    ├── rmqtt-auth-jwt.toml         # JWT 认证配置
    ├── rmqtt-acl.toml              # ACL 访问控制
    └── rmqtt-retainer.toml         # 保留消息配置
```

## JWT 认证配置

### 方式一：安装时配置（推荐）

在 1Panel 安装应用时填写：
- **JWT 证书（PEM）**：粘贴 Casdoor 应用的证书内容
- **JWT 签发者**：Casdoor 服务地址（如 `https://casdoor.example.com`）
- **JWT 受众**：Casdoor 应用的 Client ID

### 方式二：安装后手动配置

1. **配置 JWT 证书**
   ```bash
   nano /opt/1panel/apps/local/rmqtt/rmqtt/data/jwt_cert.pem
   # 粘贴 Casdoor 应用证书
   ```

2. **修改 JWT 认证配置**（可选）
   ```bash
   nano /opt/1panel/apps/local/rmqtt/rmqtt/data/rmqtt-plugins/rmqtt-auth-jwt.toml
   # 取消注释并修改 validate_claims.iss 和 validate_claims.aud
   ```

3. **重启容器**
   ```bash
   docker restart <容器名>
   ```

### JWT 签名验证方式

RMQTT 支持两种 JWT 签名验证方式：

#### 1. RSA 公钥验证（默认，推荐）

```toml
encrypt = "public-key"
public_key = "/app/rmqtt/data/jwt_cert.pem"
hmac_base64 = ""  # 不需要，留空即可
```

- 使用 RSA 公钥验证 JWT 签名
- 适合 Casdoor 等使用 RSA 证书的系统
- 更安全，公钥可以公开

#### 2. HMAC 对称密钥验证

```toml
encrypt = "hmac"
hmac_base64 = "your-base64-encoded-secret"  # 必须填写
public_key = ""  # 不需要
```

- 使用共享密钥验证 JWT 签名
- 密钥需要 Base64 编码
- 适合简单场景，但密钥需要保密

| 加密方式 | encrypt 值 | 需要的字段 |
|---------|-----------|-----------|
| RSA 公钥 | `public-key` | `public_key` + `hmac_base64=""` |
| HMAC | `hmac` | `hmac_base64` (必填) |

## 安全配置

### 禁止匿名访问

默认配置已禁用匿名访问：
```toml
listener.tcp.external.allow_anonymous = false
```

### ACL 访问控制

默认 ACL 规则：
- 管理员账号拥有完全访问权限
- 设备只能访问自己的主题空间
- 默认拒绝所有未明确允许的操作

## 测试连接

```bash
# 1. 从 Casdoor 获取 JWT
JWT_TOKEN=$(curl -s -X POST https://your-casdoor/api/login/oauth/access_token \
  -d "grant_type=password" \
  -d "username=device001" \
  -d "password=device_password" \
  -d "client_id=your_client_id" \
  -d "client_secret=your_client_secret" | jq -r '.access_token')

# 2. 使用 JWT 连接 MQTT
mosquitto_pub -h localhost -p 1883 \
  -u "device001" \
  -P "$JWT_TOKEN" \
  -t "test/topic" \
  -m "Hello from JWT auth"
```

## 官方文档

- https://github.com/rmqtt/rmqtt
- https://github.com/rmqtt/rmqtt/blob/master/docs/zh_CN/README.md
