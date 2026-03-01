# Nginx

高性能的 HTTP 和反向代理服务器，也是一个 IMAP/POP3/SMTP 服务器。

## 功能特点

- 高性能 HTTP 服务器
- 反向代理服务器
- 负载均衡
- SSL/TLS 支持
- 静态文件服务

## 目录说明

- `html/` - 静态文件目录
- `conf.d/` - 配置文件目录
- `ssl/` - SSL 证书目录
- `logs/` - 日志目录

## 使用说明

1. 复制 `.env.sample` 为 `.env`
2. 根据需要修改环境变量
3. 运行 `docker-compose up -d`

## 访问地址

- HTTP: http://localhost:80
- HTTPS: https://localhost:443 (需要配置 SSL 证书)
