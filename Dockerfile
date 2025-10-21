# Start from Debian-based Node (Bookworm or Bullseye)
FROM node:20-bookworm

# Install necessary system dependencies for Playwright browsers
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libgbm-dev libasound2 libatk1.0-0 libcups2 libfontconfig1 \
    libgdk-pixbuf2.0-0 libgtk-3-0 libpango-1.0-0 libx11-xcb1 \
    libxcb-dri3-0 libxtst6 libnss3 libnspr4 && \
    rm -rf /var/lib/apt/lists/*

# Install n8n globally
RUN npm install -g n8n

# Install Playwright globally
RUN npm install -g playwright

# Install Playwright browsers and dependencies
RUN npx playwright install --with-deps

# Configure environment (optional)
ENV N8N_PORT=5678
ENV N8N_HOST="0.0.0.0"

# Use node user for security
USER node

# Expose n8n port
EXPOSE 5678

# Start n8n
CMD ["n8n"]

