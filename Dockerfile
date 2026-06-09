FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies with a clean slate
# --no-audit and --no-fund speed things up and reduce network noise
RUN npm install --omit=dev --no-audit --no-fund

# Copy the rest of your code
COPY . .

# Expose the port
EXPOSE 3000

# Start the app
CMD ["node", "index.js"]
