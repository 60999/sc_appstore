# V2RayA

V2RayA 是一个支持透明代理的 V2Ray Linux 客户端，带 Web GUI。

## 仓库来源

本应用配置来自：`https://github.com/60999/sc_appstore`

## 端口说明

| 端口 | 用途 | 说明 |
|------|------|------|
| 2017 | Web UI | Web 管理界面 |
| 20170 | SOCKS5 | SOCKS5 代理端口 |
| 20171 | HTTP | HTTP 代理端口 |
| 20172 | SS | Shadowsocks 端口 |

## 配置说明

### V2Ray 内核路径

- `/usr/local/bin/xray`（默认）：使用 Xray 内核
- `/usr/local/bin/v2ray`：使用 V2Ray 内核

### IPTables 模式

- `legacy`（默认）：传统模式，适用于大多数系统
- `nftables`：NFTables 后端模式

### NFTables 支持

- `off`（默认）：关闭 NFTables 支持
- `on`：开启 NFTables 支持（适用于使用 nftables 的系统）

## 首次使用

1. 访问 `http://your-server:2017`
2. 创建管理员账号
3. 导入订阅或节点
4. 启动代理

## 注意事项

- 本配置不使用 `--privileged` 和 `--network=host`，因此不支持全局透明代理
- 如需透明代理功能，请在服务器上手动配置

## 官方文档

- https://v2raya.org/docs/
- https://github.com/v2rayA/v2rayA
