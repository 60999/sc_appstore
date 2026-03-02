# Vikunja

开源任务管理工具，类似 Todoist 的替代品。

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

## 访问地址

安装时请填写用户实际访问的完整 URL，如 `https://vikunja.example.com`

**注意**：不要使用 `localhost`、`127.0.0.1` 或内网 IP。
