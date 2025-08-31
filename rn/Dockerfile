# Using Debian-based node for better fs polling compat than Alpine
FROM node:22-bullseye

WORKDIR /app

# Install yarn (Node 22 ships corepack—enable it)
RUN corepack enable

# Helpful tools (optional)
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
      git bash ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Copy package manifests first for faster layer caching
COPY package.json yarn.lock ./

RUN yarn install

# Copy source (bind mount will overlay in dev)
COPY . .

EXPOSE 8081
