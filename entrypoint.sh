#!/bin/bash

cd /app
pnpm i

if [ -n "$PLUGIN_LIST" ]; then
    echo "检测到 PLUGIN_LIST 环境变量: $PLUGIN_LIST"
    
    IFS=',' read -ra PLUGINS <<< "$PLUGIN_LIST"
    
    for plugin in "${PLUGINS[@]}"; do
        plugin=$(echo "$plugin" | xargs)
        
        if [ -n "$plugin" ]; then
            echo "正在安装插件: $plugin"
            pnpm add "$plugin" -w
        fi
    done
    
    echo "所有插件安装完成"
else
    echo "未检测到 PLUGIN_LIST 环境变量"
fi

exec pnpm app