# Use the most stable LTS version
FROM node:lts-slim

WORKDIR /app

# Copy only package files first to leverage Docker cache
COPY package*.json ./

# Use 'npm ci' instead of 'npm install'
# 'npm ci' is designed specifically for automated environments (Continuous Integration)
# It is faster, more reliable, and less memory-intensive
RUN npm ci --omit=dev

# Copy the rest of the application
COPY . .

EXPOSE 3000

CMD ["node", "index.js"]
