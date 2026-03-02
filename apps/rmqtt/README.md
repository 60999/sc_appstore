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

## 认证配置

RMQTT 支持 JWT 认证。如果使用 Casdoor JWT 认证：
1. 在 Casdoor 中创建应用
2. 获取 JWT 公钥
3. 在安装时填写 JWT 公钥（PEM 格式）

## 官方文档

- https://github.com/rmqtt/rmqtt
- https://github.com/rmqtt/rmqtt/blob/master/docs/zh_CN/README.md
