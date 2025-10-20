# Start from the MAIN official n8n image. This is the corrected line.
FROM docker.n8n.io/n8nio/n8n:latest

# Switch to 'root' user to install software
USER root

# Install system libraries needed for Playwright's browsers
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    libgbm-dev libasound2 libatk1.0-0 libcups2 libfontconfig1 \
    libgdk-pixbuf2.0-0 libgtk-3-0 libpango-1.0-0 libx11-xcb1 \
    libxcb-dri3-0 libxtst6 libxt6 libnss3 libnspr4 \
    && rm -rf /var/lib/apt/lists/*

# Install Playwright and its browsers
RUN pip install playwright
RUN playwright install --with-deps

# Switch back to the secure 'node' user
USER node
