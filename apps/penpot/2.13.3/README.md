# Penpot

开源设计与代码协作工具，类似 Figma 的替代品。

## 仓库来源

本应用配置来自：`https://github.com/60999/sc_appstore`

## 镜像获取说明

**重要**：Penpot 镜像托管在 `ghcr.io`，需要特殊处理才能拉取。

### 方法一：使用代理

配置 Docker daemon 代理后直接拉取：

```bash
# 配置 /etc/docker/daemon.json
{
  "proxies": {
    "default": {
      "httpProxy": "http://127.0.0.1:7890",
      "httpsProxy": "http://127.0.0.1:7890"
    }
  }
}

# 重启 Docker 后拉取
docker pull ghcr.io/penpot/backend:2.13.3
docker pull ghcr.io/penpot/frontend:2.13.3
```

### 方法二：使用 GitHub Token 认证

```bash
# 创建 GitHub Personal Access Token (需要 read:packages 权限)
echo $GITHUB_TOKEN | docker login ghcr.io -u USERNAME --password-stdin

# 认证后拉取
docker pull ghcr.io/penpot/backend:2.13.3
docker pull ghcr.io/penpot/frontend:2.13.3
```

## 应用访问地址配置

**重要**：应用访问地址（`PANEL_APP_URL`）**必须填写**，否则应用无法正常工作。

**填写要求**：
- 必须填写用户实际访问的完整 URL 地址
- 不能使用 `localhost`、`127.0.0.1`、`172.x.x.x` 等内部地址
- 必须是用户浏览器能够访问到的地址

## 官方文档

- https://penpot.app/
- https://github.com/penpot/penpot
