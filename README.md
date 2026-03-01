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
