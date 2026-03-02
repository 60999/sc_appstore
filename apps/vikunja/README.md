# Vikunja

开源的待办事项应用，帮助你组织生活和工作。

## 安装后配置

### 权限问题

Vikunja 容器以 `uid=1000` 运行，如果遇到权限错误，请在服务器上执行：

```bash
# 查找 Vikunja 数据目录
VIKUNJA_DATA=$(docker inspect <容器名> --format '{{ range .Mounts }}{{ if eq .Destination "/app/vikunja/files" }}{{ .Source }}{{ end }}{{ end }}')

# 修复权限
chmod -R 777 "$VIKUNJA_DATA"

# 重启容器
docker restart <容器名>
```

或者直接：
```bash
chmod -R 777 /opt/1panel/apps/local/vikunja/vikunja/data/vikunja
docker restart <容器名>
```

## 应用访问地址配置

**重要**：应用访问地址（`PANEL_APP_URL`）**必须填写**，否则应用无法正常工作。

**填写要求**：
- 必须填写用户实际访问的完整 URL 地址
- 不能使用 `localhost`、`127.0.0.1`、`172.x.x.x` 等内部地址
- 必须是用户浏览器能够访问到的地址

**正确示例**：
- 使用域名（推荐）：`https://vikunja.example.com`
- 使用公网 IP：`http://123.45.67.89:9004`

## 首次登录

首次访问时需要注册新账号。

## 官方文档

- https://vikunja.io/docs/
- https://github.com/go-vikunja/vikunja
