# Use Alpine for a smaller footprint
FROM node:16-alpine

# Set working directory
WORKDIR /usr/src/app

# Copy package files first (better caching)
COPY package*.json ./

# Install only production dependencies
RUN npm install --only=production

# Copy the rest of the app
COPY . .

# Security: Don't run as root
USER node

# Document the port
EXPOSE 3000

# Start command
CMD [ "node", "server.js" ]