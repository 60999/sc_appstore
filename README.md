# 1Panel 应用商店 - 自定义应用库

## 简介

这是一个适配 1Panel 商店 2.0 版本的 Docker 应用配置库。
致力于一键运行各种 Docker 应用，无需复杂配置，享受便利和高效。

## 目录结构

```
├── apps/                    # 应用目录
│   └── [应用名称]/          # 具体应用
│       ├── versions/        # 版本目录
│       │   └── latest/      # 最新版本
│       │       ├── docker-compose.yml
│       │       └── .env.sample
│       └── data/            # 数据持久化目录
├── README.md                # 项目说明
└── LICENSE                  # 许可证
```

## 使用方式

### 国内网络

#### 使用 git 命令获取应用

```bash
git clone -b main https://ghp.ci/https://github.com/[你的用户名]/appstore /opt/1panel/resource/apps/local/appstore-localApps

cp -rf /opt/1panel/resource/apps/local/appstore-localApps/apps/* /opt/1panel/resource/apps/local/

rm -rf /opt/1panel/resource/apps/local/appstore-localApps
```

#### 使用压缩包方式获取应用

```bash
wget -P /opt/1panel/resource/apps/local https://ghp.ci/https://github.com/[你的用户名]/appstore/archive/refs/heads/main.zip

unzip -o -d /opt/1panel/resource/apps/local/ /opt/1panel/resource/apps/local/main.zip

cp -rf /opt/1panel/resource/apps/local/appstore-main/apps/* /opt/1panel/resource/apps/local/

rm -rf /opt/1panel/resource/apps/local/appstore-main

rm -rf /opt/1panel/resource/apps/local/main.zip
```

### 国际互联网络

#### 使用 git 命令获取应用

```bash
git clone -b main https://github.com/[你的用户名]/appstore /opt/1panel/resource/apps/local/appstore-localApps

cp -rf /opt/1panel/resource/apps/local/appstore-localApps/apps/* /opt/1panel/resource/apps/local/

rm -rf /opt/1panel/resource/apps/local/appstore-localApps
```

#### 使用压缩包方式获取应用

```bash
wget -P /opt/1panel/resource/apps/local https://github.com/[你的用户名]/appstore/archive/refs/heads/main.zip

unzip -o -d /opt/1panel/resource/apps/local/ /opt/1panel/resource/apps/local/main.zip

cp -rf /opt/1panel/resource/apps/local/appstore-main/apps/* /opt/1panel/resource/apps/local/

rm -rf /opt/1panel/resource/apps/local/appstore-main

rm -rf /opt/1panel/resource/apps/local/main.zip
```

## 手动运行应用

本仓库应用支持直接 docker-compose up 运行：

```bash
# 进入应用的最新版本目录
cd /opt/1panel/resource/apps/local/[应用名称]/versions/latest/

# 复制 .env.sample 为 .env
cp .env.sample .env

# 编辑 .env 文件，修改参数
nano .env

# 启动应用
docker-compose up -d
```

## 添加新应用

1. 在 `apps/` 目录下创建应用文件夹
2. 创建 `versions/latest/` 目录结构
3. 添加 `docker-compose.yml` 文件
4. 添加 `.env.sample` 环境变量示例文件
5. 创建 `data/` 目录用于数据持久化

## 免责声明

1. **镜像容器适配**：本项目仅针对原 docker 镜像容器运行进行针对 1Panel 应用商店的适配。我们不对任何原始镜像的有效性做出任何明示或暗示的保证或声明，并且不对使用本仓库应用所造成的任何影响负责。用户在使用本项目时应自行承担风险。

2. **法律遵守**：用户在使用本仓库时必须遵守所在国家与地区的法律法规。某些应用可能受到特定国家法律的限制，用户需自行了解并遵守相关法律要求。本仓库不对用户违反法律法规所产生的任何后果负责。

3. **免责声明接受**：用户在导入本仓库并使用其中的应用时，即表示用户已经阅读、理解并同意接受本免责声明的所有条款和条件。

## 许可证

MIT License
