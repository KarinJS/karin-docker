#!/bin/bash
DEFAULT_PORT=7777
DOCKER_IMAGE="karinjs/karin:latest"
DEFAULT_PATH="/opt/karin"
echo '欢迎使用 Karin 安装脚本'
# 输入端口跟挂载路径
while true; do
    read -p "请输入本地端口号1 ~ 65535(默认 $DEFAULT_PORT): " PORT
    PORT=${PORT:-$DEFAULT_PORT}
    if ! [[ "$PORT" =~ ^[0-9]+$ ]]; then
        echo "请输入一个有效的数字端口号"
        continue
    elif [ "$PORT" -lt 1 ] || [ "$PORT" -gt 65535 ]; then
        echo "端口号必须在 1 到 65535 之间"
    else
        break
    fi
done

    read -p "请输入本地挂载路径(默认 /opt/karin): " INSTALL_PATH
INSTALL_PATH=${INSTALL_PATH:-$DEFAULT_PATH}
# 检查curl是否安装
    if command -v curl >/dev/null 2>&1; then
        echo "curl 已安装"
    else
        echo "正在安装 curl..."
        if command -v apt-get >/dev/null 2>&1; then
            apt-get update && apt-get install -y curl
        elif command -v yum >/dev/null 2>&1; then
            yum install -y curl
        elif command -v pacman >/dev/null 2>&1; then
            pacman -Sy --noconfirm curl
        else
            echo "无法安装 curl: 未找到包管理器"
            exit 1
        fi
        echo "curl 安装完成"
    fi


# 检查docker是否安装
    if command -v docker >/dev/null 2>&1; then
        echo "Docker 已安装"
    else
        echo "正在安装 Docker..."
        if command -v pacman >/dev/null 2>&1; then
            pacman -Sy --noconfirm docker
        else
            curl -fsSL https://get.docker.com | bash
        fi
        echo "Docker 安装完成"
    fi

# 安装Karin
    echo "正在安装 Karin..."
    docker pull $DOCKER_IMAGE
    docker run -d --name karin --restart=always \
    -e TZ=Asia/Shanghai \
    -p $PORT:7777 \
    -v $INSTALL_PATH/@karinjs:/app/@karinjs \
    -v $INSTALL_PATH/plugins:/app/plugins \
    $DOCKER_IMAGE
    echo "Karin 安装完成, 安装目录为 $INSTALL_PATH, 端口号为 $PORT"
    echo -e "可使用\ndocker start karin 启动Karin\ndocker stop karin 停止Karin\ndocker logs -f karin 查看日志"