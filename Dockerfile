FROM node:18-alpine

# Add this line to manually patch any OS-level vulnerabilities
RUN apk update && apk upgrade --no-cache

WORKDIR /app
COPY package*.json ./
RUN npm install --omit=dev
COPY . .
EXPOSE 3000
CMD ["node", "index.js"]
