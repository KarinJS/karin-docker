<div align="center">
  <img src="https://socialify.git.ci/KarinJS/karin-docker/image?language=1&name=1&owner=1&theme=Auto">
</div>

<div align="center">

Karin 的 Docker 镜像仓库，提供开箱即用的容器化部署方案

</div>

<br />

<div align="center">

[![License](https://img.shields.io/github/license/KarinJS/karin-docker?style=for-the-badge)](LICENSE)
[![Docker Pulls](https://img.shields.io/docker/pulls/karinjs/karin?style=for-the-badge)](https://hub.docker.com/r/karinjs/karin)

</div>

<br />

---

<div align="center">

**[镜像说明](#镜像说明) • [快速开始](#快速开始) • [一键安装](#一键安装) • [docker-compose](#docker-compose) • [本地构建](#本地构建)**

</div>

---

## 镜像说明

本仓库提供两个镜像，按需选择：

| Tag | 说明 | 适用场景 |
|-----|------|---------|
| `latest` | 基础镜像，基于 `node:22-bookworm-slim`，内置 ffmpeg、redis、openssl 等 | 一般使用 |
| `browser` | 浏览器版镜像，在基础镜像上额外包含 Chromium 及其系统依赖 | 需要浏览器功能（如网页截图、Puppeteer） |

> [!TIP]
> 两个镜像均支持 `linux/amd64` 和 `linux/arm64` 架构。

## 快速开始

### docker run

```bash
# 基础镜像
docker run -d \
  --name karin \
  --restart=always \
  -e TZ=Asia/Shanghai \
  -p 7777:7777 \
  -v /opt/karin/data:/app \
  karinjs/karin:latest

# 浏览器版镜像
docker run -d \
  --name karin \
  --restart=always \
  -e TZ=Asia/Shanghai \
  -p 7777:7777 \
  -v /opt/karin/data:/app \
  karinjs/karin:browser
```

### 常用命令

```bash
# 查看日志
docker logs -f karin

# 停止 / 启动
docker stop karin
docker start karin
```

## 一键安装

提供安装脚本，自动检测并安装 Docker，拉取镜像并启动容器：

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/KarinJS/karin-docker/main/install.sh)
```

脚本支持自定义端口和挂载路径。

## docker-compose

### 基础镜像

```yaml
services:
  karin:
    image: karinjs/karin:latest
    container_name: karin
    restart: unless-stopped
    environment:
      - TZ=Asia/Shanghai
    ports:
      - "7777:7777"
    volumes:
      - /opt/karin/data:/app
```

### 浏览器版镜像

```yaml
services:
  karin:
    image: karinjs/karin:browser
    container_name: karin
    restart: unless-stopped
    environment:
      - TZ=Asia/Shanghai
    ports:
      - "7777:7777"
    volumes:
      - /opt/karin/data:/app
```

## 本地构建

```bash
# 构建基础镜像
docker build -t karinjs/karin:latest .

# 构建浏览器版镜像
docker build -f browser.Dockerfile -t karinjs/karin:browser .
```

