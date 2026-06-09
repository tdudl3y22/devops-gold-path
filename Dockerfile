FROM node:lts-slim

# Force memory limits to prevent the 254 error
ENV NODE_OPTIONS="--max-old-space-size=2048"

WORKDIR /app

# The "Wildcard" Copy: This looks for any file starting with 'package' and ends with '.json'
# This handles package.json and package-lock.json if it exists
COPY package*.json ./

# The Lightest Install
RUN npm install --omit=dev --no-audit --no-fund --prefer-offline

# Copy everything else
COPY . .

EXPOSE 3000

CMD ["node", "index.js"]
