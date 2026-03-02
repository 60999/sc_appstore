# 1Panel 应用商店 - 自定义应用库

## 简介

这是一个适配 1Panel 商店 2.0 版本的 Docker 应用配置库。
致力于一键运行各种 Docker 应用，无需复杂配置，享受便利和高效。

## 应用列表

| 应用 | 版本 | 描述 |
|------|------|------|
| RMQTT | 0.18.1 | 高性能分布式 MQTT 消息代理 |
| Vikunja | 2.1.0 | 开源待办事项应用 |
| Baserow | 2.1.3 | 无代码数据库构建平台 |
| Spug | 3.3.3 | 轻量级自动化运维平台 |
| Penpot | 2.13.3 | 开源设计与代码协作工具 |

## 目录结构

```
├── apps/                    # 应用目录
│   └── [应用名称]/          # 具体应用
│       ├── [版本号]/        # 版本目录（直接在应用目录下）
│       │   ├── docker-compose.yml
│       │   └── data.yml
│       ├── data.yml         # 应用元数据
│       └── logo.png         # 应用图标
├── data.yml                 # 商店元数据
├── README.md                # 项目说明
└── LICENSE                  # 许可证
```

## 使用方式

### 国内网络

#### 使用 git 命令获取应用

```bash
git clone -b main https://ghp.ci/https://github.com/60999/sc_appstore /opt/1panel/resource/apps/local/appstore-localApps

cp -rf /opt/1panel/resource/apps/local/appstore-localApps/apps/* /opt/1panel/resource/apps/local/

rm -rf /opt/1panel/resource/apps/local/appstore-localApps
```

#### 使用压缩包方式获取应用

```bash
wget -P /opt/1panel/resource/apps/local https://ghp.ci/https://github.com/60999/sc_appstore/archive/refs/heads/main.zip

unzip -o -d /opt/1panel/resource/apps/local/ /opt/1panel/resource/apps/local/main.zip

cp -rf /opt/1panel/resource/apps/local/sc_appstore-main/apps/* /opt/1panel/resource/apps/local/

rm -rf /opt/1panel/resource/apps/local/sc_appstore-main

rm -rf /opt/1panel/resource/apps/local/main.zip
```

### 国际互联网络

#### 使用 git 命令获取应用

```bash
git clone -b main https://github.com/60999/sc_appstore /opt/1panel/resource/apps/local/appstore-localApps

cp -rf /opt/1panel/resource/apps/local/appstore-localApps/apps/* /opt/1panel/resource/apps/local/

rm -rf /opt/1panel/resource/apps/local/appstore-localApps
```

#### 使用压缩包方式获取应用

```bash
wget -P /opt/1panel/resource/apps/local https://github.com/60999/sc_appstore/archive/refs/heads/main.zip

unzip -o -d /opt/1panel/resource/apps/local/ /opt/1panel/resource/apps/local/main.zip

cp -rf /opt/1panel/resource/apps/local/sc_appstore-main/apps/* /opt/1panel/resource/apps/local/

rm -rf /opt/1panel/resource/apps/local/sc_appstore-main

rm -rf /opt/1panel/resource/apps/local/main.zip
```

## 离线安装（镜像文件加载）

如果服务器无法访问 Docker 镜像仓库，可以提前下载镜像 tar 文件，然后在服务器上加载。

### 步骤 1：下载镜像文件

在有网络的机器上下载镜像并导出：

```bash
# 拉取镜像（Penpot 使用 DaoCloud 加速源，其他镜像可选）
docker pull ghcr.m.daocloud.io/penpot/backend:2.13.3
docker pull ghcr.m.daocloud.io/penpot/frontend:2.13.3
docker pull vikunja/vikunja:2.1.0
docker pull openspug/spug:3.3.2
docker pull baserow/baserow:2.1.3
docker pull rmqtt/rmqtt:0.18.0

# 重新标记为原始镜像名（重要！）
docker tag ghcr.m.daocloud.io/penpot/backend:2.13.3 ghcr.io/penpot/backend:2.13.3
docker tag ghcr.m.daocloud.io/penpot/frontend:2.13.3 ghcr.io/penpot/frontend:2.13.3

# 导出镜像为 tar 文件（使用原始镜像名）
docker save -o penpot-backend.tar ghcr.io/penpot/backend:2.13.3
docker save -o penpot-frontend.tar ghcr.io/penpot/frontend:2.13.3
docker save -o vikunja.tar vikunja/vikunja:2.1.0
docker save -o spug.tar openspug/spug:3.3.2
docker save -o baserow.tar baserow/baserow:2.1.3
docker save -o rmqtt.tar rmqtt/rmqtt:0.18.0
```

**注意**：
- Spug GitHub 最新版是 v3.3.3，但 Docker Hub 只有 3.3.2
- RMQTT GitHub 最新版是 0.18.1，但 Docker Hub 只有 0.18.0
- **Penpot 镜像托管在 ghcr.io，直接拉取会返回 denied，需使用 DaoCloud 加速源 `ghcr.m.daocloud.io`**
- 如果 Docker Hub 镜像拉取慢，可以使用加速镜像源：`docker.m.daocloud.io`

### 步骤 2：上传到服务器

将 tar 文件上传到服务器，例如 `/opt/images/` 目录。

### 步骤 3：加载镜像

```bash
# 加载所有镜像
docker load -i /opt/images/penpot-backend.tar
docker load -i /opt/images/penpot-frontend.tar
docker load -i /opt/images/vikunja.tar
docker load -i /opt/images/spug.tar
docker load -i /opt/images/baserow.tar
docker load -i /opt/images/rmqtt.tar

# 验证镜像已加载
docker images
```

### 步骤 4：在 1Panel 中安装应用

镜像加载完成后，即可在 1Panel 中正常安装应用。

### 一键加载脚本

```bash
#!/bin/bash
# 将此脚本放在镜像 tar 文件所在目录执行

IMAGE_DIR="/opt/images"

for tar_file in "$IMAGE_DIR"/*.tar; do
    if [ -f "$tar_file" ]; then
        echo "加载镜像: $tar_file"
        docker load -i "$tar_file"
    fi
done

echo "所有镜像加载完成"
docker images
```

## 自动更新脚本

可在 1Panel 计划任务中添加以下脚本，实现自动更新本仓库应用。

**注意**：本脚本会将应用直接部署到 1Panel 本地应用目录，与其他本地应用共存。

### 国内网络脚本

```bash
#!/bin/bash

# ============================================
# 1Panel 应用商店更新脚本（国内网络）
# 功能：自动选择最快镜像、下载、解压、更新应用
# ============================================

# 基础配置
GITHUB_USER="60999"
GITHUB_REPO="sc_appstore"
LOCAL_DIR="/opt/1panel/resource/apps/local"
TEMP_ZIP="${LOCAL_DIR}/sc_appstore.zip"
EXTRACT_DIR="${LOCAL_DIR}/${GITHUB_REPO}-main"

# ============================================
# 代理配置（可选）
# 如需使用代理，取消注释并填写以下变量
# ============================================
# PROXY_TYPE="socks5"                    # 代理类型: socks5 或 http
# PROXY_HOST="127.0.0.1"                 # 代理地址
# PROXY_PORT="1080"                      # 代理端口
# PROXY_USER=""                          # 代理用户名（如无需认证则留空）
# PROXY_PASS=""                          # 代理密码（如无需认证则留空）

# 本仓库包含的应用列表
APPS=("baserow" "penpot" "rmqtt" "spug" "vikunja")

# 镜像加速域名列表
MIRROR_DOMAINS=(
    "ghproxy.cn"
    "mirror.ghproxy.com"
    "ghp.ci"
    "gh-proxy.com"
)

# ============================================
# 函数：构建代理参数
# 返回：curl 代理参数字符串
# ============================================
build_proxy_args() {
    local proxy_args=""
    
    if [ -n "$PROXY_TYPE" ] && [ -n "$PROXY_HOST" ] && [ -n "$PROXY_PORT" ]; then
        local proxy_url=""
        
        if [ -n "$PROXY_USER" ] && [ -n "$PROXY_PASS" ]; then
            proxy_url="${PROXY_TYPE}://${PROXY_USER}:${PROXY_PASS}@${PROXY_HOST}:${PROXY_PORT}"
        else
            proxy_url="${PROXY_TYPE}://${PROXY_HOST}:${PROXY_PORT}"
        fi
        
        proxy_args="--proxy ${proxy_url}"
        echo "使用代理: ${PROXY_TYPE}://${PROXY_HOST}:${PROXY_PORT}" >&2
    fi
    
    echo "${proxy_args}"
}

# ============================================
# 函数：测试 URL 是否可访问
# 返回：响应时间（毫秒），失败返回99999
# ============================================
test_url_speed() {
    local test_url="$1"
    local proxy_args="$2"
    local start_time end_time duration
    
    start_time=$(date +%s%3N 2>/dev/null || date +%s)000
    
    if curl -fsSL --connect-timeout 5 --max-time 10 ${proxy_args} -o /dev/null "${test_url}" 2>/dev/null; then
        end_time=$(date +%s%3N 2>/dev/null || date +%s)000
        duration=$((end_time - start_time))
        echo "${duration}"
    else
        echo "99999"
    fi
}

# ============================================
# 函数：选择最佳下载源
# 优先检测 GitHub 直连，再检测镜像加速
# 输出：日志输出到stderr，返回URL到stdout
# ============================================
select_best_source() {
    local zip_path="$1"
    local proxy_args="$2"
    local github_url="https://github.com${zip_path}"
    
    echo "正在检测下载源..." >&2
    
    # 优先检测 GitHub 是否可以直接访问
    echo -n "  测试 GitHub 直连... " >&2
    github_time=$(test_url_speed "${github_url}" "${proxy_args}")
    
    if [ "$github_time" -lt 99999 ]; then
        echo "${github_time}ms ✓" >&2
        echo "使用 GitHub 直连: ${github_time}ms" >&2
        echo "${github_url}"
        return 0
    else
        echo "不可用" >&2
    fi
    
    # GitHub 不可用，检测镜像加速
    echo "GitHub 直连不可用，检测镜像加速..." >&2
    
    local fastest_domain=""
    local fastest_time=99999
    
    for domain in "${MIRROR_DOMAINS[@]}"; do
        echo -n "  测试 ${domain}... " >&2
        local mirror_url="https://${domain}/https://github.com${zip_path}"
        time_ms=$(test_url_speed "${mirror_url}" "${proxy_args}")
        
        if [ "$time_ms" -lt 99999 ]; then
            echo "${time_ms}ms" >&2
            if [ "$time_ms" -lt "$fastest_time" ]; then
                fastest_time="$time_ms"
                fastest_domain="$domain"
            fi
        else
            echo "超时" >&2
        fi
    done
    
    if [ -z "$fastest_domain" ]; then
        echo "错误：所有下载源都不可用" >&2
        echo ""
    else
        echo "选择最快镜像: ${fastest_domain} (${fastest_time}ms)" >&2
        echo "https://${fastest_domain}/https://github.com${zip_path}"
    fi
}

# ============================================
# 主流程
# ============================================
echo "============================================"
echo "开始更新 ${GITHUB_REPO} 应用商店..."
echo "============================================"

# 清理临时文件
rm -rf "${TEMP_ZIP}" "${EXTRACT_DIR}"

# 构建代理参数
PROXY_ARGS=$(build_proxy_args)

# 选择最佳下载源（优先检测 GitHub 直连）
ZIP_PATH="/${GITHUB_USER}/${GITHUB_REPO}/archive/refs/heads/main.zip"
DOWNLOAD_URL=$(select_best_source "${ZIP_PATH}" "${PROXY_ARGS}")

if [ -z "$DOWNLOAD_URL" ]; then
    echo "错误：无法找到可用的下载源"
    exit 1
fi

echo "下载地址: ${DOWNLOAD_URL}"

# 下载文件
echo "正在下载..."
if ! curl -fSL --connect-timeout 30 --max-time 180 --retry 3 ${PROXY_ARGS} \
    -o "${TEMP_ZIP}" "${DOWNLOAD_URL}"; then
    echo "错误：下载失败"
    rm -rf "${TEMP_ZIP}"
    exit 1
fi

# 验证文件
if ! file "${TEMP_ZIP}" | grep -q "Zip archive"; then
    echo "错误：下载的文件不是有效的 zip 压缩包"
    rm -rf "${TEMP_ZIP}"
    exit 1
fi

FILE_SIZE=$(stat -c%s "${TEMP_ZIP}" 2>/dev/null || echo "0")
if [ "$FILE_SIZE" -lt 1000 ]; then
    echo "错误：文件太小 (${FILE_SIZE} 字节)，可能下载不完整"
    rm -rf "${TEMP_ZIP}"
    exit 1
fi
echo "下载成功，文件大小: ${FILE_SIZE} 字节"

# 解压文件
echo "正在解压..."
if ! unzip -q -o "${TEMP_ZIP}" -d "${LOCAL_DIR}/"; then
    echo "错误：解压失败"
    rm -rf "${TEMP_ZIP}" "${EXTRACT_DIR}"
    exit 1
fi

if [ ! -d "${EXTRACT_DIR}/apps" ]; then
    echo "错误：解压后找不到 apps 目录"
    rm -rf "${TEMP_ZIP}" "${EXTRACT_DIR}"
    exit 1
fi

# 复制商店元数据
cp -f "${EXTRACT_DIR}/data.yml" "${LOCAL_DIR}/"

# 清理旧应用目录（包括各种大小写变体）
echo "清理旧版本..."
for app in "${APPS[@]}"; do
    rm -rf "${LOCAL_DIR}/${app}"
    # 首字母大写
    app_cap="$(echo "${app:0:1}" | tr '[:lower:]' '[:upper:]')${app:1}"
    rm -rf "${LOCAL_DIR}/${app_cap}"
    # 全大写
    app_upper=$(echo "$app" | tr '[:lower:]' '[:upper:]')
    rm -rf "${LOCAL_DIR}/${app_upper}"
done

# 安装新应用
echo "安装应用..."
for app_dir in "${EXTRACT_DIR}/apps"/*; do
    if [ -d "$app_dir" ]; then
        app_name=$(basename "$app_dir")
        echo "  - ${app_name}"
        cp -rf "$app_dir" "${LOCAL_DIR}/"
    fi
done

# 验证安装
echo "验证安装..."
VERIFY_FAILED=0
for app in "${APPS[@]}"; do
    app_dir="${LOCAL_DIR}/${app}"
    
    if [ ! -d "${app_dir}" ]; then
        echo "  错误: ${app} 目录不存在"
        VERIFY_FAILED=1
        continue
    fi
    
    # 检查是否有版本目录（直接在应用目录下）
    version_count=$(find "${app_dir}" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l)
    if [ "$version_count" -eq 0 ]; then
        echo "  错误: ${app} 没有版本目录"
        VERIFY_FAILED=1
        continue
    fi
    
    # 检查版本目录中是否有 docker-compose.yml
    for ver_dir in "${app_dir}"/*; do
        if [ -d "$ver_dir" ]; then
            ver_name=$(basename "$ver_dir")
            if [ ! -f "${ver_dir}/docker-compose.yml" ]; then
                echo "  错误: ${app}/${ver_name} 缺少 docker-compose.yml"
                VERIFY_FAILED=1
            else
                echo "  ✓ ${app}/${ver_name}"
            fi
        fi
    done
done

# 清理临时文件
rm -rf "${TEMP_ZIP}" "${EXTRACT_DIR}"

if [ $VERIFY_FAILED -eq 1 ]; then
    echo "============================================"
    echo "警告：部分应用验证失败，请检查日志"
    echo "============================================"
else
    echo "============================================"
    echo "${GITHUB_REPO} 应用商店更新完成！"
    echo "请在 1Panel 应用商店中刷新本地应用。"
    echo "============================================"
fi
```

### 国际互联网络脚本

```bash
#!/bin/bash

# ============================================
# 1Panel 应用商店更新脚本（国际网络）
# 功能：直接从 GitHub 克隆、更新应用
# ============================================

# 基础配置
GITHUB_USER="60999"
GITHUB_REPO="sc_appstore"
LOCAL_DIR="/opt/1panel/resource/apps/local"
TEMP_DIR="${LOCAL_DIR}/${GITHUB_REPO}_temp"

# 本仓库包含的应用列表
APPS=("baserow" "penpot" "rmqtt" "spug" "vikunja")

# ============================================
# 主流程
# ============================================
echo "============================================"
echo "开始更新 ${GITHUB_REPO} 应用商店..."
echo "============================================"

# 清理临时目录
rm -rf "${TEMP_DIR}"

# 克隆仓库
STORE_URL="https://github.com/${GITHUB_USER}/${GITHUB_REPO}"
echo "克隆地址: ${STORE_URL}"

if ! git clone -b main "${STORE_URL}" "${TEMP_DIR}"; then
    echo "错误：克隆失败，请检查网络连接"
    rm -rf "${TEMP_DIR}"
    exit 1
fi

if [ ! -d "${TEMP_DIR}/apps" ]; then
    echo "错误：克隆后找不到 apps 目录"
    rm -rf "${TEMP_DIR}"
    exit 1
fi

# 复制商店元数据
cp -f "${TEMP_DIR}/data.yml" "${LOCAL_DIR}/"

# 清理旧应用目录
echo "清理旧版本..."
for app in "${APPS[@]}"; do
    rm -rf "${LOCAL_DIR}/${app}"
    app_cap="$(echo "${app:0:1}" | tr '[:lower:]' '[:upper:]')${app:1}"
    rm -rf "${LOCAL_DIR}/${app_cap}"
    app_upper=$(echo "$app" | tr '[:lower:]' '[:upper:]')
    rm -rf "${LOCAL_DIR}/${app_upper}"
done

# 安装新应用
echo "安装应用..."
for app_dir in "${TEMP_DIR}/apps"/*; do
    if [ -d "$app_dir" ]; then
        app_name=$(basename "$app_dir")
        echo "  - ${app_name}"
        cp -rf "$app_dir" "${LOCAL_DIR}/"
    fi
done

# 清理临时目录
rm -rf "${TEMP_DIR}"

echo "============================================"
echo "${GITHUB_REPO} 应用商店更新完成！"
echo "请在 1Panel 应用商店中刷新本地应用。"
echo "============================================"
```

### 设置计划任务

1. 登录 1Panel 面板
2. 进入 **计划任务** 菜单
3. 点击 **创建计划任务**
4. 配置如下：
   - **任务类型**：Shell 脚本
   - **任务名称**：更新 sc_appstore 应用商店
   - **执行周期**：选择合适的时间（如每天凌晨 3:00）
   - **脚本内容**：粘贴上述脚本
5. 保存并启用任务

### 目录结构

更新后的目录结构：

```
/opt/1panel/resource/apps/local/
├── data.yml              # 本地应用商店元数据
├── rmqtt/                # RMQTT 应用
├── vikunja/              # Vikunja 应用
├── baserow/              # Baserow 应用
├── spug/                 # Spug 应用
├── penpot/               # Penpot 应用
└── (其他应用)/           # 其他本地应用
```

**注意**：如果服务器上已有其他第三方应用，本脚本只会更新本仓库包含的应用（rmqtt、vikunja、baserow、spug、penpot），不会影响其他应用。

## 添加新应用

1. 在 `apps/` 目录下创建应用文件夹（使用小写字母）
2. 创建 `versions/[版本号]/` 目录结构
3. 添加 `docker-compose.yml` 文件
4. 添加 `data.yml` 表单配置文件
5. 在应用根目录添加 `data.yml` 应用元数据
6. 添加 `logo.png` 应用图标

## 依赖说明

| 应用 | PostgreSQL | Redis |
|------|------------|-------|
| RMQTT | 不需要 | 不需要 |
| Vikunja | 必需 | 不需要 |
| Baserow | 必需 | 不需要 |
| Spug | 必需 | 不需要 |
| Penpot | 必需 | 必需 |

## 免责声明

1. **镜像容器适配**：本项目仅针对原 docker 镜像容器运行进行针对 1Panel 应用商店的适配。我们不对任何原始镜像的有效性做出任何明示或暗示的保证或声明，并且不对使用本仓库应用所造成的任何影响负责。用户在使用本项目时应自行承担风险。

2. **法律遵守**：用户在使用本仓库时必须遵守所在国家与地区的法律法规。某些应用可能受到特定国家法律的限制，用户需自行了解并遵守相关法律要求。本仓库不对用户违反法律法规所产生的任何后果负责。

3. **免责声明接受**：用户在导入本仓库并使用其中的应用时，即表示用户已经阅读、理解并同意接受本免责声明的所有条款和条件。

## 许可证

MIT License
