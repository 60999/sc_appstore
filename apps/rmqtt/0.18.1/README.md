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

### 1. 获取 Casdoor 证书

1. 登录 Casdoor 管理后台
2. 进入应用详情页
3. 复制证书内容（PEM 格式）

### 2. 配置证书

将 Casdoor 应用的证书内容粘贴到 `data/jwt_cert.pem` 文件：

```bash
# 在服务器上编辑证书文件
nano /opt/1panel/apps/local/rmqtt/rmqtt/data/jwt_cert.pem
```

### 3. 修改 JWT 认证配置

编辑 `data/rmqtt-plugins/rmqtt-auth-jwt.toml`：

```toml
# 修改签发者验证（可选）
validate_claims.iss = ["https://your-casdoor-domain"]

# 修改受众验证（可选）
validate_claims.aud = ["your-client-id"]
```

### 4. 重启容器

```bash
docker restart <容器名>
```

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
