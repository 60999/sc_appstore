# Vikunja

开源的待办事项应用，帮助你组织生活和工作。

## 功能特点

- 任务管理：创建、编辑、删除任务
- 项目管理：组织任务到项目中
- 团队协作：与团队成员共享项目和任务
- 标签系统：使用标签分类任务
- 优先级设置：设置任务优先级
- 截止日期：设置任务截止日期
- 重复任务：设置重复任务
- 子任务：创建子任务
- 附件：上传文件附件
- 评论：在任务上添加评论
- 提醒：设置任务提醒
- 移动应用：支持 iOS 和 Android 应用
- API 支持：完整的 REST API
- 开源：完全开源，可自托管

## 目录说明

- `db/` - PostgreSQL 数据库数据目录
- `files/` - 文件上传目录

## 应用访问地址配置

**重要**：应用访问地址（`PANEL_APP_URL`）**必须填写**，否则应用无法正常工作。

**填写要求**：
- 必须填写用户实际访问的完整 URL 地址
- 不能使用 `localhost`、`127.0.0.1`、`172.x.x.x` 等内部地址
- 必须是用户浏览器能够访问到的地址

**正确示例**：
- 使用域名（推荐）：`https://vikunja.example.com`
- 使用公网 IP：`http://123.45.67.89:9004`
- 使用 1Panel 反向代理：`https://vikunja.example.com`

**错误示例**：
- ❌ `http://localhost:9004` - 用户无法访问
- ❌ `http://127.0.0.1:9004` - 用户无法访问
- ❌ `http://172.16.0.1:9004` - 内网地址用户无法访问

**为什么必须填写正确的访问地址？**
- Vikunja 使用此地址生成邮件链接、邀请链接
- 前端资源加载依赖正确的 URL
- API 调用需要正确的域名配置

## 使用说明

1. 复制 `.env.sample` 为 `.env`
2. 修改 `JWT_SECRET` 为随机字符串（重要！）
3. 根据需要修改其他环境变量
4. 运行 `docker-compose up -d`

## 访问地址

- 前端界面: http://服务器IP:9004
- API: http://服务器IP:9004/api/v1

## 默认账号

首次访问时需要注册新账号。

## 配置说明

### 数据库

- 使用 PostgreSQL 15
- 默认用户名: `vikunja`
- 默认密码: `vikunja`
- 默认数据库: `vikunja`

### 安全

- 请务必修改 `JWT_SECRET` 为强随机字符串
- 建议在生产环境中使用 HTTPS
- 定期备份数据库和文件数据

## 备份

### 备份数据库

```bash
docker exec vikunja-db pg_dump -U vikunja vikunja > backup.sql
```

### 恢复数据库

```bash
docker exec -i vikunja-db psql -U vikunja vikunja < backup.sql
```

### 备份文件

直接备份 `./data/files/` 目录。

## 官方文档

https://vikunja.io/docs/
https://github.com/go-vikunja/vikunja

## 仓库来源

本应用配置来自：https://github.com/60999/sc_appstore
