# 应用模板说明

本目录用于存放适配 1Panel 应用商店的 Docker 应用配置。

## 目录结构规范

```
apps/
└── [应用名称]/              # 应用名称，使用小写字母和连字符
    ├── README.md            # 应用说明文档
    └── versions/            # 版本目录
        └── latest/          # 最新版本（必须）
            ├── docker-compose.yml  # Docker Compose 配置文件
            ├── .env.sample        # 环境变量示例文件
            └── data/              # 数据持久化目录
                ├── conf/          # 配置文件目录（可选）
                ├── data/          # 应用数据目录（可选）
                └── logs/          # 日志目录（可选）
```

## 文件说明

### docker-compose.yml

Docker Compose 配置文件，定义应用的容器配置。

**注意事项：**
- 使用 `${变量名:-默认值}` 格式引用环境变量
- 数据卷映射使用相对路径 `./data/`
- 网络使用自定义网络

### .env.sample

环境变量示例文件，用户需要复制为 `.env` 并修改。

**格式：**
```
# 注释说明
变量名=默认值
```

### README.md

应用说明文档，包含：
- 应用简介
- 功能特点
- 目录说明
- 使用说明
- 访问地址

## 添加新应用步骤

1. 在 `apps/` 目录下创建应用文件夹（使用小写字母和连字符）
2. 创建 `versions/latest/` 目录
3. 编写 `docker-compose.yml` 文件
4. 编写 `.env.sample` 文件
5. 创建必要的 `data/` 子目录和默认配置文件
6. 编写 `README.md` 说明文档

## 示例应用

参考 `apps/nginx/` 目录下的示例应用。
