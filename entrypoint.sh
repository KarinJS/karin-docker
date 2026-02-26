#!/bin/bash

cd /app

pnpm init && pnpm add node-karin@latest && npx karin init

exec pnpm app