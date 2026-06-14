# --- STAGE 1: Build Stage ---
FROM node:lts-slim AS builder

# Security Patch & Dependencies
RUN apt-get update && apt-get upgrade -y && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy and Install
COPY package*.json ./
RUN npm install --omit=dev --no-audit --no-fund

# Copy the rest of the app
COPY . .


# --- STAGE 2: Run Stage ---
# We start FRESH here. Everything from the "builder" stage is thrown away 
# unless we explicitly COPY it over.
FROM node:lts-slim

# Re-apply the memory limit for the runner
ENV NODE_OPTIONS="--max-old-space-size=2048"
WORKDIR /app

# COPY ONLY the necessary pieces from the builder stage
# This leaves behind the npm cache and temporary build files
COPY --from=builder /app /app

EXPOSE 3000

# Using "node index.js" directly is even lighter than "npm start"
CMD ["node", "index.js"]
