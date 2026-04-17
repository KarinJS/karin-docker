#!/bin/bash
set -e
cd /app

echo "========================================="
echo "  Karin Docker 容器启动中..."
echo "========================================="

if [ ! -f "pnpm-lock.yaml" ]; then
    echo "[1/3] 检测到首次启动,正在初始化项目..."

    if ! pnpm init; then
        echo "pnpm init 失败"
        exit 1
    fi
    
    echo "[2/3] 正在安装 node-karin..."
    if ! pnpm add node-karin@latest; then
        echo "安装 node-karin 失败"
        exit 1
    fi
    
    echo "[3/3] 正在执行 karin 初始化配置..."
    if ! npx karin init; then
        echo "karin init 失败"
        exit 1
    fi
    
    echo "项目初始化完成"
fi

if [ ! -d "node_modules/.pnpm" ]; then
    echo "检测到 node_modules 不存在,正在安装依赖..."
        if ! pnpm install; then
            echo "依赖安装失败"
            exit 1
        fi
    echo "依赖安装完成"
fi

echo "========================================="
echo "  启动 Karin 应用..."
echo "========================================="

exec pnpm app
