FROM node:22-bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    ffmpeg \
    curl \
    openssl \
    git \
    redis-server \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV PATH=/usr/local/bin:$PATH

RUN npm i -g pnpm@9

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /app

EXPOSE 7777
CMD ["bash", "/entrypoint.sh"]