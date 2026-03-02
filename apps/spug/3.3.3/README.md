# Spug

轻量级自动化运维平台。

## 安装配置

### 管理员账户

安装时需要填写管理员用户名和密码，容器启动时会自动初始化数据库和创建管理员账户。

### 手动初始化

如果自动初始化失败，可以手动执行：

```bash
# 初始化数据库并创建管理员账户
docker exec <容器名> init_spug <用户名> <密码>

# 示例
docker exec 1Panel-localspug-xxx init_spug admin Admin@123
```

初始化完成后，使用设置的用户名和密码登录 Spug。

## 数据库支持

- MySQL
- MariaDB
- PostgreSQL
