# Dockerfile لتطبيق إبداع AI
FROM node:18-alpine AS frontend-builder

# إعداد مجلد العمل للواجهة الأمامية
WORKDIR /app/frontend

# نسخ ملفات package
COPY frontend/package*.json ./

# تثبيت المتطلبات
RUN npm ci --only=production

# نسخ الكود المصدري
COPY frontend/ ./

# بناء التطبيق
RUN npm run build

# مرحلة Python للواجهة الخلفية
FROM python:3.12-slim

# تثبيت المتطلبات النظام
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# إعداد مجلد العمل
WORKDIR /app

# نسخ متطلبات Python
COPY backend/requirements.txt ./

# تثبيت متطلبات Python
RUN pip install --no-cache-dir -r requirements.txt

# نسخ الواجهة الخلفية
COPY backend/ ./

# نسخ الواجهة الأمامية المبنية
COPY --from=frontend-builder /app/frontend/dist ./static

# إنشاء مستخدم غير جذر
RUN useradd -m -u 1000 appuser && chown -R appuser:appuser /app
USER appuser

# تعريف المنافذ
EXPOSE 12000

# متغيرات البيئة
ENV PYTHONPATH=/app
ENV HOST=0.0.0.0
ENV PORT=12000

# فحص الصحة
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:12000/health || exit 1

# تشغيل التطبيق
CMD ["python", "main.py"]