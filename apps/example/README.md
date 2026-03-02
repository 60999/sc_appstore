# Example App

这是一个应用模板示例，用于创建新应用时参考。

## 仓库来源

本应用配置来自：`https://github.com/60999/sc_appstore`

## 目录结构

```
apps/
└── example/                    # 应用名称（小写，无特殊字符）
    ├── data.yml                # 应用元数据（名称、描述、标签等）
    ├── README.md               # 应用说明文档
    ├── logo.png                # 应用图标（可选，建议 512x512）
    └── 1.0.0/                  # 版本目录
        ├── data.yml            # 版本配置（端口、环境变量等）
        ├── docker-compose.yml  # Docker Compose 配置
        └── README.md           # 版本说明文档
```

## 文件说明

### 1. 应用级 data.yml

```yaml
name: example                  # 应用 ID（小写，无特殊字符）
tags:                          # 标签列表
  - demo
  - template
title: Example App             # 显示名称
description: 应用模板示例       # 中文描述
descriptionEn: Example app...  # 英文描述
logoUrl: https://...           # 图标 URL
websiteUrl: https://...        # 官网地址
githubUrl: https://...         # GitHub 地址
author: example                # 作者
type: tool                     # 类型：tool/service/runtime
crossVersionUpdate: true       # 是否支持跨版本更新
limit: 0                       # 安装数量限制（0=无限制）
recommend: 0                   # 推荐级别
website: https://...           # 官网
document: https://...          # 文档
sources:                       # 镜像来源
  - docker: example/app:1.0.0
```

### 2. 版本级 data.yml

```yaml
additionalProperties:
  formFields:
    - default: 8080            # 默认值
      edit: true               # 是否可编辑
      envKey: PANEL_APP_PORT_HTTP  # 环境变量名
      labelEn: HTTP Port       # 英文标签
      labelZh: HTTP 端口       # 中文标签
      label:                   # 多语言标签
        en: HTTP Port
        ja: HTTPポート
        zh: HTTP 端口
      required: true           # 是否必填
      rule: paramPort          # 验证规则
      type: number             # 类型：number/text/password
```

### 3. docker-compose.yml

```yaml
services:
  example:
    image: example/app:1.0.0
    container_name: ${CONTAINER_NAME}
    restart: unless-stopped
    networks:
      - 1panel-network
    ports:
      - "0.0.0.0:${PANEL_APP_PORT_HTTP}:8080"
    volumes:
      - ./data/config:/app/config
    environment:
      - TZ=${TIMEZONE:-Asia/Shanghai}
    labels:
      createdBy: "Apps"

networks:
  1panel-network:
    external: true
```

## 创建新应用步骤

1. 复制 `example` 目录为新应用名称
2. 修改 `data.yml`（应用级）的元数据
3. 创建版本目录（如 `1.0.0`）
4. 修改版本级 `data.yml` 的配置项
5. 修改 `docker-compose.yml` 的服务配置
6. 更新 `README.md` 说明文档
7. 测试安装是否正常

## 注意事项

- 端口绑定使用 `0.0.0.0` 而非 `127.0.0.1`
- 环境变量名使用大写下划线格式
- YAML 中包含特殊字符的值需要用引号包裹
- 多语言标签支持：en/ja/ms/pt-br/ru/ko/zh/zh-Hant
