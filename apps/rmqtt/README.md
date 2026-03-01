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
- JWT AUTH/ACL
- WebHook 支持
- HTTP APIs
- $SYS 系统主题
- 会话信息存储
- 未过期消息存储
- MQTT 桥接（入站/出站）
- Apache Kafka 桥接（入站/出站）
- Apache Pulsar 桥接（入站/出站）
- NATS 桥接（入站/出站）
- TLS 支持
- WebSocket 支持
- WebSocket-TLS 支持
- MQTT over QUIC 支持
- 可扩展插件支持
- 指标与统计
- 速率限制
- Inflight 和队列管理
- 消息重发

## 目录说明

- `log/` - 日志目录
- `config/` - 配置文件目录

## 使用说明

### 单节点模式

1. 复制 `.env.sample` 为 `.env`
2. 保持默认配置
3. 运行 `docker-compose up -d`

### 集群模式

1. 复制 `.env.sample` 为 `.env`
2. 修改以下配置：
   - `NODE_ID` - 设置节点ID（1、2、3...）
   - `PLUGINS_DEFAULT_STARTUPS` - 设置为 `rmqtt-cluster-raft`
   - `NODE_GRPC_ADDRS` - 配置所有节点的 gRPC 地址
   - `RAFT_PEER_ADDRS` - 配置所有节点的 Raft 地址
3. 运行 `docker-compose up -d`

## 访问地址

- MQTT: mqtt://localhost:1883
- MQTT TLS: mqtts://localhost:8883
- HTTP API: http://localhost:6060
- 健康检查: http://localhost:6060/api/v1/health/check

## 配置文件

配置文件位于 `./data/config/` 目录，包括：
- `rmqtt.toml` - 主配置文件
- `rmqtt-acl.toml` - ACL 访问控制配置
- `rmqtt-auth.toml` - 认证配置

## 官方文档

https://github.com/rmqtt/rmqtt
