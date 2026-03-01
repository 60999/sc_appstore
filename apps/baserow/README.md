# Baserow

开源的无代码数据库构建平台，使用 AI 构建数据库、自动化、应用和智能体。

## 功能特点

- 无代码数据库：像电子表格一样创建数据库
- 应用构建：创建自定义应用和门户
- 自动化：自动化重复工作流程
- 仪表板：可视化数据
- AI 助手：使用自然语言创建数据库和工作流
- 数据所有权：完全控制数据
- API 优先：完整的 REST API
- 可扩展：支持任何规模
- 安全合规：GDPR、HIPAA、SOC 2 Type II 合规
- 自托管：完全自托管，无存储限制
- 开源：MIT 许可证

## 目录说明

- `baserow/` - Baserow 应用数据
- `db/` - PostgreSQL 数据库数据

## 使用说明

1. 复制 `.env.sample` 为 `.env`
2. 修改 `SECRET_KEY` 和 `JWT_KEY` 为强随机字符串（重要！）
3. 根据需要配置 SMTP 邮件服务
4. 运行 `docker-compose up -d`

## 访问地址

- Web 界面: http://localhost
- API 文档: http://localhost/api/docs/

## 默认账号

首次访问时需要注册新账号。

## 配置说明

### 数据库

- 使用 PostgreSQL 15
- 默认用户名: `baserow`
- 默认密码: `baserow`
- 默认数据库: `baserow`

### Redis

- 使用 Redis 7
- 用于缓存和任务队列

### 安全

- 请务必修改 `SECRET_KEY` 和 `JWT_KEY` 为强随机字符串
- 建议在生产环境中使用 HTTPS
- 定期备份数据库和应用数据

### 邮件配置

如需发送邮件通知，请配置 SMTP：
- `SMTP_ENABLED=true`
- `SMTP_HOST` - SMTP 服务器地址
- `SMTP_PORT` - SMTP 端口（通常为 587）
- `SMTP_USER` - SMTP 用户名
- `SMTP_PASSWORD` - SMTP 密码
- `SMTP_TLS=true` - 使用 TLS

## 备份

### 备份数据库

```bash
docker exec baserow-db pg_dump -U baserow baserow > backup.sql
```

### 恢复数据库

```bash
docker exec -i baserow-db psql -U baserow baserow < backup.sql
```

### 备份应用数据

直接备份 `./data/baserow/` 目录。

## 性能优化

- 根据服务器配置调整容器资源限制
- 使用外部 PostgreSQL 和 Redis 提高性能
- 配置 CDN 加速静态资源访问
- 启用 Redis 缓存

## 官方文档

https://baserow.io/docs/
https://github.com/baserow/baserow
