FROM debian:bookworm-slim

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

RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash - \
  && apt-get install -y nodejs

ENV PATH=/usr/local/bin:$PATH

RUN npm i -g pnpm@9

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /app
RUN pnpm init && pnpm add node-karin@latest && npx karin init

EXPOSE 7777
CMD ["bash", "/entrypoint.sh"]