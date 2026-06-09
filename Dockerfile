# Switching to 'slim' - still small, but more stable than alpine for networking
FROM node:18-slim

# Install essential build tools (sometimes needed for npm installs)
RUN apt-get update && apt-get install -y python3 make g++ && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy package files
COPY package*.json ./

# Standard install
RUN npm install --omit=dev

# Copy the rest
COPY . .

EXPOSE 3000

CMD ["node", "index.js"]
