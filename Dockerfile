FROM node:18-slim

# Chromium dependencies
RUN apt-get update && apt-get install -y \
  chromium \
  ca-certificates \
  fonts-liberation \
  libasound2 \
  libatk-bridge2.0-0 \
  libatk1.0-0 \
  libcups2 \
  libdrm2 \
  libgbm1 \
  libgtk-3-0 \
  libnss3 \
  libx11-xcb1 \
  libxcomposite1 \
  libxdamage1 \
  libxrandr2 \
  xdg-utils \
  --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

# ⛔ عطّل husky نهائيًا
ENV HUSKY=0

ENV NODE_ENV=production
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

WORKDIR /app
COPY . .

# مهم: ثبت mocha types
RUN npm install --save-dev @types/mocha

# ثبت dependencies بدون ما husky يشتغل
RUN npm install --legacy-peer-deps

EXPOSE 21465
CMD ["npm", "start"]
