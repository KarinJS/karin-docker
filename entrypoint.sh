#!/bin/bash

cd /app

if [ ! -f "pnpm-lock.yaml" ]; then
    echo "正在初始化 karin ..."
    pnpm init
    pnpm add node-karin@latest
    npx karin init
fi

exec pnpm app
