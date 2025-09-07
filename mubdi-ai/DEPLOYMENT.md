# دليل النشر - مُبدع AI

## خيارات النشر

### 1. النشر المحلي (Local Deployment)

#### الطريقة التقليدية
```bash
# تشغيل سريع
./start.sh

# أو تشغيل منفصل
cd backend && python main.py &
cd frontend && npm run preview -- --host 0.0.0.0 --port 12001 &
```

#### باستخدام Docker
```bash
# بناء وتشغيل
docker-compose up --build -d

# مراقبة السجلات
docker-compose logs -f

# إيقاف
docker-compose down
```

### 2. النشر السحابي (Cloud Deployment)

#### على Google Cloud Platform

**إعداد المشروع:**
```bash
# تسجيل الدخول
gcloud auth login

# إنشاء مشروع جديد
gcloud projects create mubdi-ai-project

# تعيين المشروع
gcloud config set project mubdi-ai-project
```

**النشر على Cloud Run:**
```bash
# بناء ورفع الصورة
gcloud builds submit --tag gcr.io/mubdi-ai-project/mubdi-ai

# النشر
gcloud run deploy mubdi-ai \
  --image gcr.io/mubdi-ai-project/mubdi-ai \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --set-env-vars GOOGLE_API_KEY=your_api_key_here
```

#### على AWS

**باستخدام ECS:**
```bash
# إنشاء ECR repository
aws ecr create-repository --repository-name mubdi-ai

# بناء ورفع الصورة
docker build -t mubdi-ai .
docker tag mubdi-ai:latest 123456789012.dkr.ecr.us-east-1.amazonaws.com/mubdi-ai:latest
docker push 123456789012.dkr.ecr.us-east-1.amazonaws.com/mubdi-ai:latest

# إنشاء ECS service
aws ecs create-service --service-name mubdi-ai --task-definition mubdi-ai-task
```

**باستخدام Elastic Beanstalk:**
```bash
# تثبيت EB CLI
pip install awsebcli

# تهيئة التطبيق
eb init mubdi-ai

# النشر
eb create production
eb deploy
```

#### على Azure

**باستخدام Container Instances:**
```bash
# إنشاء resource group
az group create --name mubdi-ai-rg --location eastus

# النشر
az container create \
  --resource-group mubdi-ai-rg \
  --name mubdi-ai \
  --image mubdi-ai:latest \
  --ports 12000 \
  --environment-variables GOOGLE_API_KEY=your_api_key_here
```

### 3. النشر على VPS

#### إعداد الخادم
```bash
# تحديث النظام
sudo apt update && sudo apt upgrade -y

# تثبيت Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# تثبيت Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# إعداد Nginx (اختياري)
sudo apt install nginx -y
```

#### تكوين Nginx
```nginx
# /etc/nginx/sites-available/mubdi-ai
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://localhost:12000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

```bash
# تفعيل الموقع
sudo ln -s /etc/nginx/sites-available/mubdi-ai /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
```

#### SSL مع Let's Encrypt
```bash
# تثبيت Certbot
sudo apt install certbot python3-certbot-nginx -y

# الحصول على شهادة SSL
sudo certbot --nginx -d your-domain.com
```

### 4. النشر على Kubernetes

#### ملف Deployment
```yaml
# k8s/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mubdi-ai
spec:
  replicas: 3
  selector:
    matchLabels:
      app: mubdi-ai
  template:
    metadata:
      labels:
        app: mubdi-ai
    spec:
      containers:
      - name: mubdi-ai
        image: mubdi-ai:latest
        ports:
        - containerPort: 12000
        env:
        - name: GOOGLE_API_KEY
          valueFrom:
            secretKeyRef:
              name: mubdi-ai-secrets
              key: google-api-key
---
apiVersion: v1
kind: Service
metadata:
  name: mubdi-ai-service
spec:
  selector:
    app: mubdi-ai
  ports:
  - port: 80
    targetPort: 12000
  type: LoadBalancer
```

#### النشر
```bash
# إنشاء Secret
kubectl create secret generic mubdi-ai-secrets \
  --from-literal=google-api-key=your_api_key_here

# النشر
kubectl apply -f k8s/deployment.yaml

# مراقبة الحالة
kubectl get pods
kubectl get services
```

## متغيرات البيئة للإنتاج

```env
# API Keys
GOOGLE_API_KEY=your_production_api_key

# Server Configuration
HOST=0.0.0.0
PORT=12000
DEBUG=false
LOG_LEVEL=WARNING

# CORS (حسب النطاق)
CORS_ORIGINS=https://your-domain.com,https://www.your-domain.com

# Security (اختياري)
SECRET_KEY=your_secret_key_here
JWT_SECRET=your_jwt_secret_here
```

## مراقبة الأداء

### استخدام Prometheus + Grafana
```yaml
# docker-compose.monitoring.yml
version: '3.8'
services:
  prometheus:
    image: prom/prometheus
    ports:
      - "9090:9090"
    volumes:
      - ./monitoring/prometheus.yml:/etc/prometheus/prometheus.yml

  grafana:
    image: grafana/grafana
    ports:
      - "3000:3000"
    environment:
      - GF_SECURITY_ADMIN_PASSWORD=admin
```

### فحص الصحة
```bash
# فحص دوري للصحة
curl -f http://your-domain.com/health || exit 1

# مراقبة الاستجابة
curl -w "@curl-format.txt" -o /dev/null -s http://your-domain.com/health
```

## النسخ الاحتياطي

### قاعدة البيانات (إذا كانت موجودة)
```bash
# نسخ احتياطي يومي
0 2 * * * /usr/local/bin/backup-db.sh
```

### الملفات المهمة
```bash
# نسخ احتياطي للتكوين
tar -czf backup-$(date +%Y%m%d).tar.gz \
  backend/.env \
  docker-compose.yml \
  nginx.conf
```

## الأمان

### إعدادات الأمان الأساسية
```bash
# تحديث النظام
sudo apt update && sudo apt upgrade -y

# إعداد جدار الحماية
sudo ufw allow 22
sudo ufw allow 80
sudo ufw allow 443
sudo ufw enable

# تعطيل root login
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
sudo systemctl restart ssh
```

### مراقبة السجلات
```bash
# مراقبة سجلات التطبيق
tail -f /var/log/mubdi-ai/app.log

# مراقبة سجلات النظام
journalctl -u mubdi-ai -f
```

## استكشاف الأخطاء

### مشاكل شائعة

**1. خطأ في الاتصال بـ API:**
```bash
# فحص متغيرات البيئة
docker exec mubdi-ai env | grep GOOGLE_API_KEY

# فحص السجلات
docker logs mubdi-ai
```

**2. مشاكل الذاكرة:**
```bash
# زيادة حد الذاكرة
docker run --memory=2g mubdi-ai
```

**3. مشاكل الشبكة:**
```bash
# فحص المنافذ
netstat -tlnp | grep 12000

# فحص الاتصال
curl -I http://localhost:12000/health
```

## التحديث

### تحديث التطبيق
```bash
# سحب آخر إصدار
git pull origin main

# إعادة بناء ونشر
docker-compose down
docker-compose up --build -d

# فحص الحالة
docker-compose ps
```

### تحديث تدريجي (Zero Downtime)
```bash
# باستخدام Docker Swarm
docker service update --image mubdi-ai:latest mubdi-ai

# باستخدام Kubernetes
kubectl set image deployment/mubdi-ai mubdi-ai=mubdi-ai:latest
```

---

**ملاحظة:** تأكد من اختبار جميع التحديثات في بيئة التطوير قبل النشر في الإنتاج.