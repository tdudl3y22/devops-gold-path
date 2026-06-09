FROM node:lts-slim

WORKDIR /app

# Copy package files
COPY package*.json ./

# The 'Forgiving' Install:
# --no-package-lock: Don't worry if the lock file is missing or mismatched
# --no-audit / --no-fund: Skip the extra network checks that cause timeouts
RUN npm install --omit=dev --no-package-lock --no-audit --no-fund

COPY . .

EXPOSE 3000

CMD ["node", "index.js"]
