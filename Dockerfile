FROM node:lts-slim

# Step 1: Tell Node.js to stay under 2GB of memory (Prevents Exit 254)
ENV NODE_OPTIONS="--max-old-space-size=2048"

WORKDIR /app

# Step 2: Copy ONLY package.json (skip the lock file entirely for now)
COPY package.json ./

# Step 3: Run the lightest possible install
# --prefer-offline: Uses local cache if possible to save network/memory
# --no-bin-links: Skips creating symlinks (saves disk I/O)
RUN npm install --omit=dev --no-audit --no-fund --prefer-offline --no-bin-links

# Step 4: Copy the rest of the app
COPY . .

EXPOSE 3000

CMD ["node", "index.js"]
