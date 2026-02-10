FROM node:24-trixie

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    ffmpeg \
    curl \
    openssl \
    git \
    redis-server \
    fontconfig \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV PATH=/usr/local/bin:$PATH

RUN npm i -g pnpm@9

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /app
RUN pnpm init && pnpm add node-karin@latest && npx karin init

EXPOSE 7777
CMD ["bash", "/entrypoint.sh"]