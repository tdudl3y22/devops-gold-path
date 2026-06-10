# Use the most stable LTS version based on Debian (Slim)
FROM node:lts-slim

# SECURITY PATCH (Added 9:26 PM): 
# Manually upgrade system libraries to fix CRITICAL vulnerabilities (like libgnutls30)
# We use '&&' to keep the image small and 'rm -rf' to delete the "grocery flyer" catalog files.
RUN apt-get update && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

# MEMORY LIMIT (The "Exit 254" Fix):
# Prevents the GitHub runner from killing the process by capping Node's RAM usage.
ENV NODE_OPTIONS="--max-old-space-size=2048"

WORKDIR /app

# Copy package files first to leverage Docker's layer caching
COPY package*.json ./

# THE FORGIVING INSTALL:
# --omit=dev: Keeps the image light by skipping testing/dev tools
# --no-audit / --no-fund: Reduces network noise and prevents timeouts
RUN npm install --omit=dev --no-audit --no-fund

# Copy the rest of the application code
COPY . .

# Standard port for web services
EXPOSE 3000

# Start the application using the script defined in package.json
CMD ["npm", "start"]
