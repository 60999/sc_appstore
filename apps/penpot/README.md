# Penpot

首个开源的设计与代码协作工具，设计师和开发者可以无缝协作。

## 功能特点

- **设计与代码协作**：设计师创建设计，开发者获取即用代码
- **交互式原型**：创建可交互的原型设计
- **设计系统**：原生设计令牌、组件和变体
- **CSS Grid 布局**：首创的 CSS Grid 布局功能
- **实时协作**：多人实时协作编辑
- **插件系统**：扩展平台能力
- **检查模式**：即时访问 SVG、CSS 和 HTML 代码
- **自托管**：完全自托管，数据自主控制
- **开放标准**：基于 SVG、CSS、HTML 和 JSON
- **免费开源**：完全免费，MPL 2.0 许可证

## 目录说明

- `postgres/` - PostgreSQL 数据库数据目录
- `redis/` - Redis 数据目录
- `assets/` - 资源文件存储目录

## 使用说明

1. 复制 `.env.sample` 为 `.env`
2. 修改数据库密码（重要！）
3. 根据需要配置其他环境变量
4. 运行 `docker-compose up -d`

## 访问地址

- Web 界面: http://服务器IP:9001
- API: http://服务器IP:9002

## 默认账号

首次访问时需要注册新账号。

## 配置说明

### 数据库

- 使用 PostgreSQL 15
- 默认用户名: `penpot`
- 默认密码: `penpot`
- 默认数据库: `penpot`

### Redis

- 使用 Redis 7
- 用于缓存和会话管理

### 安全

- 请务必修改数据库密码
- 建议在生产环境中使用 HTTPS
- 定期备份数据库和资源文件

### 存储配置

支持两种存储后端：

1. **数据库存储（默认）**
   - `STORAGE_BACKEND=assets-db`
   - 资源存储在数据库中
   - 适合小型部署

2. **文件系统存储**
   - `STORAGE_BACKEND=assets-fs`
   - 资源存储在文件系统中
   - 适合大型部署
   - 需要配置 `ASSETS_URI`

### OAuth 配置

支持以下 OAuth 提供商（可选）：

- Google: 配置 `GOOGLE_CLIENT_ID` 和 `GOOGLE_CLIENT_SECRET`
- GitHub: 配置 `GITHUB_CLIENT_ID` 和 `GITHUB_CLIENT_SECRET`
- GitLab: 配置 `GITLAB_CLIENT_ID` 和 `GITLAB_CLIENT_SECRET`

### 邮件配置

如需发送邮件通知，请配置 SMTP：
- `SMTP_ENABLED=true`
- `SMTP_HOST` - SMTP 服务器地址
- `SMTP_PORT` - SMTP 端口（通常为 587）
- `SMTP_USER` - SMTP 用户名
- `SMTP_PASSWORD` - SMTP 密码
- `SMTP_TLS=true` - 使用 TLS
- `SMTP_FROM` - 发件人地址

## 备份

### 备份数据库

```bash
docker exec penpot-postgres pg_dump -U penpot penpot > backup.sql
```

### 恢复数据库

```bash
docker exec -i penpot-postgres psql -U penpot penpot < backup.sql
```

### 备份资源

- 数据库存储：备份 `./data/postgres/` 目录
- 文件系统存储：备份 `./data/assets/` 目录

### 备份 Redis

```bash
docker exec penpot-redis redis-cli BGSAVE
```

## 性能优化

- 根据服务器配置调整容器资源限制
- 使用外部 PostgreSQL 和 Redis 提高性能
- 配置 CDN 加速静态资源访问
- 启用 Redis 持久化
- 使用文件系统存储处理大量资源

## 功能模块

### 设计工具

- 矢量图形设计
- 原型设计
- 组件和变体
- 设计令牌
- 响应式设计

### 协作功能

- 实时协作
- 评论和反馈
- 版本历史
- 团队管理

### 开发者工具

- 检查模式
- 代码导出（SVG、CSS、HTML）
- 设计系统文档
- API 访问

### 集成

- Webhook 支持
- REST API
- 插件系统
- OAuth 集成

## 官方文档

https://penpot.app/docs/
https://github.com/penpot/penpot

## 仓库来源

本应用配置来自：https://github.com/60999/sc_appstore
