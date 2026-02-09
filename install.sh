#!/bin/bash
DOCKER_IMAGE="karinjs/karin:latest"
PORT=7777
INSTALL_PATH="/opt/karin"

while getopts "p:d:" opt; do
  case $opt in
    p)
      PORT=$OPTARG
      ;;
    d)
      INSTALL_PATH=$OPTARG
      ;;
    *)
      echo "Usage: $0 [-p port] [-d install_path]"
      exit 1
      ;;
  esac
done

# 检查curl是否安装
check_curl() {
    if command -v curl >/dev/null 2>&1; then
        echo "curl 已安装"
        return 0
    else
        echo "正在安装 curl..."
        if command -v apt-get >/dev/null 2>&1; then
            apt-get update && apt-get install -y curl
        elif command -v yum >/dev/null 2>&1; then
            yum install -y curl
        elif command -v pacman >/dev/null 2>&1; then
            pacman -Sy --noconfirm curl
        else
            echo "无法安装 curl：未找到包管理器"
            exit 1
        fi
        echo "curl 安装完成"
    fi
}

# 检查docker是否安装
check_docker() {
    if command -v docker >/dev/null 2>&1; then
        echo "Docker 已安装"
        return 0
    else
        echo "正在安装 Docker..."
        if command -v pacman >/dev/null 2>&1; then
            pacman -Sy --noconfirm docker
        else
            curl -fsSL https://get.docker.com | bash
        fi
        echo "Docker 安装完成"
    fi
}

# 安装Karin
install_karin(){
    echo "正在安装 Karin..."
    docker pull $DOCKER_IMAGE
    docker run -d --name karin --restart=always \
    -e TZ=Asia/Shanghai \
    -p $PORT:7777 \
    -v $INSTALL_PATH/config:/app/@karinjs/config \
    -v $INSTALL_PATH/data:/app/@karinjs/data \
    -v $INSTALL_PATH/logs:/app/@karinjs/logs \
    -v $INSTALL_PATH/plugins:/app/plugins \
    $DOCKER_IMAGE
    source ~/.bashrc
    echo "Karin 安装完成, 安装目录为 $INSTALL_PATH"
}

# 主程序
echo '欢迎使用 Karin 安装脚本'
check_curl
check_docker
install_karin
echo '安装完成, 可使用karin命令'