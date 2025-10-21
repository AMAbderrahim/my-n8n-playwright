# Start from the official n8n Docker image
FROM n8nio/n8n:latest

# Switch to the root user to install dependencies
USER root

# Universal installer for Python and Playwright dependencies
RUN \
  if [ -f /etc/alpine-release ]; then \
    # Alpine-based system
    apk add --no-cache \
      python3 \
      py3-pip \
      chromium \
      nss \
      freetype \
      harfbuzz \
      ttf-freefont \
      udev; \
  elif [ -f /etc/debian_version ]; then \
    # Debian-based system
    apt-get update && apt-get install -y \
      python3 \
      python3-pip \
      libnss3 \
      libnspr4 \
      libatk1.0-0 \
      libatk-bridge2.0-0 \
      libcups2 \
      libdrm2 \
      libdbus-1-3 \
      libxkbcommon0 \
      libxcomposite1 \
      libxdamage1 \
      libxfixes3 \
      libxrandr2 \
      libgbm1 \
      libpango-1.0-0 \
      libcairo2 \
      libasound2 && \
    rm -rf /var/lib/apt/lists/*; \
  else \
    echo "Unsupported operating system" && exit 1; \
  fi

# Install Playwright and its browser dependencies
RUN npm install -g playwright
RUN npx playwright install --with-deps

# Switch back to the node user
USER node
