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
│       ├── versions/        # 版本目录
│       │   └── [版本号]/    # 具体版本
│       │       ├── docker-compose.yml
│       │       └── data.yml
│       ├── data.yml         # 应用元数据
│       └── logo.png         # 应用图标
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

## 自动更新脚本

可在 1Panel 计划任务中添加以下脚本，实现自动更新本仓库应用。

**注意**：本脚本会将应用直接部署到 1Panel 本地应用目录，与其他本地应用共存。

### 国内网络脚本

#### 镜像加速选项

如果某个镜像加速不可用，可以尝试其他选项：

| 加速服务 | URL 前缀 |
|----------|----------|
| ghp.ci | `https://ghp.ci/https://github.com/` |
| ghproxy.cn | `https://ghproxy.cn/https://github.com/` |
| mirror.ghproxy.com | `https://mirror.ghproxy.com/https://github.com/` |
| gh-proxy.com | `https://gh-proxy.com/https://github.com/` |
| gitclone.com | `https://gitclone.com/github.com/` |

#### 脚本（使用 ghp.ci 加速）

```bash
#!/bin/bash

# 1Panel 应用商店更新脚本（国内网络 - ghp.ci 加速）
# 将应用直接部署到 /opt/1panel/resource/apps/local/ 目录
STORE_URL="https://ghp.ci/https://github.com/60999/sc_appstore"
LOCAL_DIR="/opt/1panel/resource/apps/local"
TEMP_DIR="${LOCAL_DIR}/sc_appstore_temp"

echo "开始更新 sc_appstore 应用商店..."

# 清理临时目录
rm -rf "${TEMP_DIR}"

# 克隆最新版本
git clone -b main "${STORE_URL}" "${TEMP_DIR}"

# 检查是否克隆成功
if [ ! -d "${TEMP_DIR}/apps" ]; then
    echo "错误：克隆失败，请检查网络连接"
    rm -rf "${TEMP_DIR}"
    exit 1
fi

# 复制商店元数据文件到 local 目录
cp -f "${TEMP_DIR}/data.yml" "${LOCAL_DIR}/"

# 更新所有应用到 local 目录
for app_dir in "${TEMP_DIR}/apps"/*; do
    if [ -d "$app_dir" ]; then
        app_name=$(basename "$app_dir")
        echo "更新应用: ${app_name}"
        rm -rf "${LOCAL_DIR}/${app_name}"
        cp -rf "$app_dir" "${LOCAL_DIR}/"
    fi
done

# 清理临时目录
rm -rf "${TEMP_DIR}"

echo "sc_appstore 应用商店更新完成！"
echo "请在 1Panel 应用商店中刷新本地应用。"
```

#### 脚本（使用 ghproxy.cn 加速）

```bash
#!/bin/bash

# 1Panel 应用商店更新脚本（国内网络 - ghproxy.cn 加速）
STORE_URL="https://ghproxy.cn/https://github.com/60999/sc_appstore"
LOCAL_DIR="/opt/1panel/resource/apps/local"
TEMP_DIR="${LOCAL_DIR}/sc_appstore_temp"

echo "开始更新 sc_appstore 应用商店..."

rm -rf "${TEMP_DIR}"
git clone -b main "${STORE_URL}" "${TEMP_DIR}"

if [ ! -d "${TEMP_DIR}/apps" ]; then
    echo "错误：克隆失败，请检查网络连接"
    rm -rf "${TEMP_DIR}"
    exit 1
fi

cp -f "${TEMP_DIR}/data.yml" "${LOCAL_DIR}/"

for app_dir in "${TEMP_DIR}/apps"/*; do
    if [ -d "$app_dir" ]; then
        app_name=$(basename "$app_dir")
        echo "更新应用: ${app_name}"
        rm -rf "${LOCAL_DIR}/${app_name}"
        cp -rf "$app_dir" "${LOCAL_DIR}/"
    fi
done

rm -rf "${TEMP_DIR}"
echo "sc_appstore 应用商店更新完成！"
echo "请在 1Panel 应用商店中刷新本地应用。"
```

#### 脚本（使用压缩包方式，适合 git 克隆慢的情况）

```bash
#!/bin/bash

# 1Panel 应用商店更新脚本（国内网络 - 压缩包方式）
# 适合 git clone 速度慢的情况
STORE_URL="https://ghp.ci/https://github.com/60999/sc_appstore/archive/refs/heads/main.zip"
LOCAL_DIR="/opt/1panel/resource/apps/local"
TEMP_DIR="${LOCAL_DIR}/sc_appstore_temp"
TEMP_ZIP="${LOCAL_DIR}/sc_appstore.zip"

echo "开始更新 sc_appstore 应用商店..."

# 清理临时文件
rm -rf "${TEMP_DIR}" "${TEMP_ZIP}"

# 下载压缩包
wget -q -O "${TEMP_ZIP}" "${STORE_URL}"

if [ ! -f "${TEMP_ZIP}" ]; then
    echo "错误：下载失败，请检查网络连接"
    exit 1
fi

# 解压
unzip -q -o "${TEMP_ZIP}" -d "${LOCAL_DIR}/"

if [ ! -d "${LOCAL_DIR}/sc_appstore-main/apps" ]; then
    echo "错误：解压失败"
    rm -rf "${TEMP_ZIP}" "${LOCAL_DIR}/sc_appstore-main"
    exit 1
fi

# 复制商店元数据文件
cp -f "${LOCAL_DIR}/sc_appstore-main/data.yml" "${LOCAL_DIR}/"

# 更新所有应用
for app_dir in "${LOCAL_DIR}/sc_appstore-main/apps"/*; do
    if [ -d "$app_dir" ]; then
        app_name=$(basename "$app_dir")
        echo "更新应用: ${app_name}"
        rm -rf "${LOCAL_DIR}/${app_name}"
        cp -rf "$app_dir" "${LOCAL_DIR}/"
    fi
done

# 清理临时文件
rm -rf "${TEMP_ZIP}" "${LOCAL_DIR}/sc_appstore-main"

echo "sc_appstore 应用商店更新完成！"
echo "请在 1Panel 应用商店中刷新本地应用。"
```

### 国际互联网络脚本

```bash
#!/bin/bash

# 1Panel 应用商店更新脚本（国际网络）
# 将应用直接部署到 /opt/1panel/resource/apps/local/ 目录
STORE_URL="https://github.com/60999/sc_appstore"
LOCAL_DIR="/opt/1panel/resource/apps/local"
TEMP_DIR="${LOCAL_DIR}/sc_appstore_temp"

echo "开始更新 sc_appstore 应用商店..."

# 清理临时目录
rm -rf "${TEMP_DIR}"

# 克隆最新版本
git clone -b main "${STORE_URL}" "${TEMP_DIR}"

# 检查是否克隆成功
if [ ! -d "${TEMP_DIR}/apps" ]; then
    echo "错误：克隆失败，请检查网络连接"
    rm -rf "${TEMP_DIR}"
    exit 1
fi

# 复制商店元数据文件到 local 目录
cp -f "${TEMP_DIR}/data.yml" "${LOCAL_DIR}/"

# 更新所有应用到 local 目录
for app_dir in "${TEMP_DIR}/apps"/*; do
    if [ -d "$app_dir" ]; then
        app_name=$(basename "$app_dir")
        echo "更新应用: ${app_name}"
        rm -rf "${LOCAL_DIR}/${app_name}"
        cp -rf "$app_dir" "${LOCAL_DIR}/"
    fi
done

# 清理临时目录
rm -rf "${TEMP_DIR}"

echo "sc_appstore 应用商店更新完成！"
echo "请在 1Panel 应用商店中刷新本地应用。"
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
