FROM node:20-slim

# تثبيت كل متطلبات Puppeteer / Chromium
RUN apt-get update && apt-get install -y \
  chromium \
  wget \
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

# إعداد Puppeteer لاستخدام Chromium المثبت
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium
ENV NODE_ENV=production

WORKDIR /app

# نسخ ملفات المشروع
COPY . .

# تثبيت الاعتمادات (package.json موجود بالفعل)
RUN npm install --legacy-peer-deps

# البورت (مش إجباري لو مش عامل API)
EXPOSE 21465

# تشغيل المشروع
CMD ["npm", "start"]
