# دليل النشر على المنصات المختلفة - مُبدع AI

## نظرة عامة
يحتوي هذا الدليل على جميع ملفات التكوين اللازمة لنشر تطبيق **مُبدع AI** على منصات النشر المختلفة.

## 🏗️ هيكل ملفات النشر

```
deployment/
├── docker-compose.yml          # Docker Compose للتطوير المحلي
├── google-cloud-run.yaml       # Google Cloud Run
├── kubernetes.yaml             # Kubernetes
├── netlify.toml               # Netlify (Frontend)
├── vercel.json                # Vercel (Frontend)
├── railway.yaml               # Railway
├── heroku.yml                 # Heroku
├── aws-ecs.yaml               # AWS ECS
└── azure-container-apps.yaml  # Azure Container Apps

.github/workflows/
└── deploy.yml                 # GitHub Actions للنشر التلقائي

backend/
└── Dockerfile                 # Docker للواجهة الخلفية

frontend/
├── Dockerfile                 # Docker للواجهة الأمامية
└── nginx.conf                 # إعدادات Nginx
```

## 🚀 منصات النشر المدعومة

### 1. Google Cloud Platform

#### Google Cloud Run (موصى به للواجهة الخلفية)
```bash
# تسجيل الدخول
gcloud auth login

# تعيين المشروع
gcloud config set project YOUR_PROJECT_ID

# بناء ونشر الصورة
cd backend
gcloud builds submit --tag gcr.io/YOUR_PROJECT_ID/mubdi-ai-backend

# نشر الخدمة
gcloud run deploy mubdi-ai-backend \
  --image gcr.io/YOUR_PROJECT_ID/mubdi-ai-backend \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --set-env-vars PORT=8000,HOST=0.0.0.0 \
  --set-secrets GOOGLE_API_KEY=google-api-key:latest
```

#### Google Kubernetes Engine (GKE)
```bash
# إنشاء الكلاستر
gcloud container clusters create mubdi-ai-cluster \
  --zone us-central1-a \
  --num-nodes 3

# الحصول على بيانات الاعتماد
gcloud container clusters get-credentials mubdi-ai-cluster --zone us-central1-a

# نشر التطبيق
kubectl apply -f deployment/kubernetes.yaml
```

### 2. Amazon Web Services (AWS)

#### AWS ECS Fargate
```bash
# إنشاء ECR Repository
aws ecr create-repository --repository-name mubdi-ai-backend

# بناء ونشر الصورة
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com

cd backend
docker build -t mubdi-ai-backend .
docker tag mubdi-ai-backend:latest ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/mubdi-ai-backend:latest
docker push ACCOUNT_ID.dkr.ecr.us-east-1.amazonaws.com/mubdi-ai-backend:latest

# تسجيل Task Definition
aws ecs register-task-definition --cli-input-json file://deployment/aws-ecs-task-definition.json

# إنشاء الخدمة
aws ecs create-service --cli-input-json file://deployment/aws-ecs-service.json
```

#### AWS Lambda (للواجهة الخلفية الخفيفة)
```bash
# تثبيت Serverless Framework
npm install -g serverless

# نشر
cd backend
serverless deploy
```

### 3. Microsoft Azure

#### Azure Container Apps
```bash
# تسجيل الدخول
az login

# إنشاء Resource Group
az group create --name mubdi-ai-rg --location eastus

# إنشاء Container Registry
az acr create --resource-group mubdi-ai-rg --name mubdiai --sku Basic

# بناء ونشر الصورة
cd backend
az acr build --registry mubdiai --image mubdi-ai-backend .

# إنشاء Container App Environment
az containerapp env create \
  --name mubdi-ai-env \
  --resource-group mubdi-ai-rg \
  --location eastus

# نشر Container App
az containerapp create \
  --name mubdi-ai-backend \
  --resource-group mubdi-ai-rg \
  --environment mubdi-ai-env \
  --image mubdiai.azurecr.io/mubdi-ai-backend:latest \
  --target-port 8000 \
  --ingress external \
  --secrets google-api-key=YOUR_GOOGLE_API_KEY \
  --env-vars GOOGLE_API_KEY=secretref:google-api-key PORT=8000
```

### 4. Railway (موصى به للبساطة)

#### نشر الواجهة الخلفية
```bash
# تثبيت Railway CLI
npm install -g @railway/cli

# تسجيل الدخول
railway login

# ربط المشروع
railway link

# نشر
cd backend
railway up
```

#### إعداد متغيرات البيئة
```bash
railway variables set GOOGLE_API_KEY=YOUR_API_KEY
railway variables set PORT=8000
railway variables set HOST=0.0.0.0
```

### 5. Heroku

#### نشر الواجهة الخلفية
```bash
# تسجيل الدخول
heroku login

# إنشاء التطبيق
heroku create mubdi-ai-backend

# تعيين متغيرات البيئة
heroku config:set GOOGLE_API_KEY=YOUR_API_KEY -a mubdi-ai-backend
heroku config:set PORT=8000 -a mubdi-ai-backend

# نشر
git subtree push --prefix backend heroku main
```

### 6. Netlify (للواجهة الأمامية)

#### النشر التلقائي
1. ربط المستودع بـ Netlify
2. تعيين إعدادات البناء:
   - **Build command**: `cd frontend && npm ci && npm run build`
   - **Publish directory**: `frontend/dist`
   - **Base directory**: `/`

#### النشر اليدوي
```bash
# تثبيت Netlify CLI
npm install -g netlify-cli

# تسجيل الدخول
netlify login

# بناء التطبيق
cd frontend
npm run build

# نشر
netlify deploy --prod --dir=dist
```

### 7. Vercel (للواجهة الأمامية)

#### النشر التلقائي
1. ربط المستودع بـ Vercel
2. تعيين إعدادات المشروع:
   - **Framework Preset**: Vite
   - **Root Directory**: `frontend`
   - **Build Command**: `npm run build`
   - **Output Directory**: `dist`

#### النشر اليدوي
```bash
# تثبيت Vercel CLI
npm install -g vercel

# تسجيل الدخول
vercel login

# نشر
cd frontend
vercel --prod
```

### 8. DigitalOcean App Platform

#### إنشاء التطبيق
```yaml
# .do/app.yaml
name: mubdi-ai
services:
- name: backend
  source_dir: backend
  github:
    repo: your-username/mubdi-ai
    branch: main
  run_command: python main.py
  environment_slug: python
  instance_count: 1
  instance_size_slug: basic-xxs
  envs:
  - key: GOOGLE_API_KEY
    value: YOUR_API_KEY
    type: SECRET
  - key: PORT
    value: "8000"
  - key: HOST
    value: "0.0.0.0"
  http_port: 8000
  health_check:
    http_path: /health
- name: frontend
  source_dir: frontend
  github:
    repo: your-username/mubdi-ai
    branch: main
  build_command: npm run build
  environment_slug: node-js
  instance_count: 1
  instance_size_slug: basic-xxs
  envs:
  - key: VITE_API_URL
    value: ${backend.PUBLIC_URL}
  static_sites:
  - name: frontend
    source_dir: dist
```

## 🔧 إعداد متغيرات البيئة

### متغيرات مطلوبة للواجهة الخلفية
```bash
GOOGLE_API_KEY=your_google_api_key_here
PORT=8000
HOST=0.0.0.0
CORS_ORIGINS=https://your-frontend-domain.com
LOG_LEVEL=INFO
DEBUG=false
```

### متغيرات مطلوبة للواجهة الأمامية
```bash
VITE_API_URL=https://your-backend-domain.com
NODE_ENV=production
```

## 🔐 إدارة الأسرار

### Google Cloud
```bash
# إنشاء سر
gcloud secrets create google-api-key --data-file=-
echo "YOUR_API_KEY" | gcloud secrets create google-api-key --data-file=-

# منح الصلاحيات
gcloud secrets add-iam-policy-binding google-api-key \
  --member="serviceAccount:YOUR_SERVICE_ACCOUNT@YOUR_PROJECT.iam.gserviceaccount.com" \
  --role="roles/secretmanager.secretAccessor"
```

### AWS
```bash
# إنشاء سر
aws secretsmanager create-secret \
  --name google-api-key \
  --description "Google API Key for mubdi AI" \
  --secret-string "YOUR_API_KEY"
```

### Azure
```bash
# إنشاء Key Vault
az keyvault create --name mubdi-ai-kv --resource-group mubdi-ai-rg --location eastus

# إضافة سر
az keyvault secret set --vault-name mubdi-ai-kv --name google-api-key --value "YOUR_API_KEY"
```

## 🚦 CI/CD Pipeline

### GitHub Actions
الملف `.github/workflows/deploy.yml` يحتوي على:
- اختبار الكود
- بناء الصور
- نشر على منصات متعددة
- إشعارات النشر

### متغيرات GitHub Secrets المطلوبة
```
GOOGLE_API_KEY
GCP_SA_KEY
RAILWAY_TOKEN
HEROKU_API_KEY
HEROKU_EMAIL
NETLIFY_AUTH_TOKEN
NETLIFY_SITE_ID
VERCEL_TOKEN
ORG_ID
PROJECT_ID
KUBE_CONFIG
SLACK_WEBHOOK
DISCORD_WEBHOOK
```

## 📊 مراقبة ومتابعة

### Google Cloud Monitoring
```bash
# تفعيل المراقبة
gcloud services enable monitoring.googleapis.com
gcloud services enable logging.googleapis.com
```

### AWS CloudWatch
```bash
# إنشاء Log Group
aws logs create-log-group --log-group-name /ecs/mubdi-ai-backend
```

### Azure Monitor
```bash
# إنشاء Application Insights
az monitor app-insights component create \
  --app mubdi-ai-insights \
  --location eastus \
  --resource-group mubdi-ai-rg
```

## 🔄 التحديث والصيانة

### تحديث الصور
```bash
# بناء صورة جديدة
docker build -t mubdi-ai-backend:v2.0.0 backend/

# نشر التحديث
kubectl set image deployment/mubdi-ai-backend backend=mubdi-ai-backend:v2.0.0
```

### النسخ الاحتياطي
```bash
# نسخ احتياطي لقاعدة البيانات (إذا وجدت)
kubectl exec -it deployment/mubdi-ai-backend -- pg_dump > backup.sql

# نسخ احتياطي للإعدادات
kubectl get configmap mubdi-ai-config -o yaml > config-backup.yaml
```

## 🆘 استكشاف الأخطاء

### مشاكل شائعة وحلولها

#### 1. خطأ في مفتاح API
```bash
# التحقق من السر
kubectl get secret google-api-secret -o yaml
```

#### 2. مشاكل الشبكة
```bash
# فحص الخدمات
kubectl get services
kubectl describe service mubdi-ai-backend-service
```

#### 3. مشاكل الذاكرة
```bash
# مراقبة استخدام الموارد
kubectl top pods
```

## 📞 الدعم الفني

للحصول على المساعدة:
1. راجع السجلات: `kubectl logs deployment/mubdi-ai-backend`
2. تحقق من الحالة: `kubectl get pods`
3. راجع الأحداث: `kubectl get events`

---

**ملاحظة**: تأكد من تحديث جميع المتغيرات والمعرفات الخاصة بمشروعك قبل النشر.