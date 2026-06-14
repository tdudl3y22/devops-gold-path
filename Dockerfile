# --- STAGE 1: Build Stage ---
FROM node:lts-slim AS builder
RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY package*.json ./
RUN npm install --omit=dev --no-audit --no-fund
COPY . .

# --- STAGE 2: Run Stage ---
FROM node:lts-slim

# NEW: Install 'curl' so the healthcheck can work
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

ENV NODE_OPTIONS="--max-old-space-size=2048"
WORKDIR /app
COPY --from=builder /app /app

# NEW: The Healthcheck
# --interval: How often to check (30s)
# --timeout: How long to wait for a response (3s)
# --start-period: Give the app 5s to boot up before checking
# --retries: Try 3 times before calling it "dead"
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/ || exit 1

EXPOSE 3000
CMD ["node", "index.js"]
