# دليل النشر الإنتاجي لمُبدع AI على Google Cloud
# Production Deployment Guide for Mubdi AI on Google Cloud

## نظرة عامة / Overview

هذا الدليل يوضح كيفية نشر مشروع مُبدع AI على Google Cloud باستخدام Kubernetes وGoogle Container Registry.

This guide explains how to deploy the Mubdi AI project to Google Cloud using Kubernetes and Google Container Registry.

## المتطلبات المسبقة / Prerequisites

### 1. الأدوات المطلوبة / Required Tools
- Docker
- Google Cloud SDK (gcloud)
- kubectl
- Git

### 2. الحسابات والصلاحيات / Accounts and Permissions
- حساب Google Cloud مع الصلاحيات المناسبة
- مشروع Google Cloud: `mubdiai-470007`
- Kubernetes Cluster: `autopilot-cluster-mubdi`

### 3. المفاتيح المطلوبة / Required API Keys
- ✅ Gemini API Key: `AIzaSyALn-91dw7uWBE-mE7N3BcP1Uw0cCugRuM`
- ✅ Google Cloud Credentials: `application_default_credentials.json`

## الخدمات المستخدمة / Services Used

### Google Cloud APIs
- **Vertex AI API** - لخدمات Imagen و Veo
- **Generative AI API** - لخدمات Gemini
- **Text-to-Speech API** - للصوت
- **Container Registry** - لحفظ Docker Images
- **Google Kubernetes Engine (GKE)** - للنشر
- **Cloud Storage** - لحفظ الملفات المولدة

### تطبيق مُبدع AI / Mubdi AI Application
- **Backend**: FastAPI + Python
- **Frontend**: React + TypeScript + Vite
- **AI Services**: Gemini, Imagen 4.0, Veo 3.0

## خطوات النشر / Deployment Steps

### الطريقة الأولى: النشر التلقائي / Method 1: Automated Deployment

```bash
# الانتقال إلى مجلد المشروع
cd mubdi-ai

# تشغيل سكريبت النشر التلقائي
./deploy.sh
```

### الطريقة الثانية: النشر اليدوي / Method 2: Manual Deployment

#### 1. إعداد المصادقة / Authentication Setup

```bash
# تفعيل حساب الخدمة
export GOOGLE_APPLICATION_CREDENTIALS="$(pwd)/application_default_credentials.json"
gcloud auth activate-service-account --key-file=application_default_credentials.json

# تعيين المشروع
gcloud config set project mubdiai-470007
```

#### 2. تفعيل APIs المطلوبة / Enable Required APIs

```bash
gcloud services enable container.googleapis.com
gcloud services enable containerregistry.googleapis.com
gcloud services enable cloudbuild.googleapis.com
gcloud services enable aiplatform.googleapis.com
gcloud services enable generativelanguage.googleapis.com
gcloud services enable texttospeech.googleapis.com
gcloud services enable storage.googleapis.com
```

#### 3. إعداد Docker / Docker Setup

```bash
gcloud auth configure-docker
```

#### 4. بناء ورفع الصور / Build and Push Images

```bash
# بناء صورة الواجهة الخلفية
cd backend
docker build -t gcr.io/mubdiai-470007/mubdi-ai-backend:latest .
docker push gcr.io/mubdiai-470007/mubdi-ai-backend:latest
cd ..

# بناء صورة الواجهة الأمامية
cd frontend
docker build -t gcr.io/mubdiai-470007/mubdi-ai-frontend:latest .
docker push gcr.io/mubdiai-470007/mubdi-ai-frontend:latest
cd ..
```

#### 5. الاتصال بـ Kubernetes / Connect to Kubernetes

```bash
gcloud container clusters get-credentials autopilot-cluster-mubdi --region us-central1 --project mubdiai-470007
```

#### 6. إنشاء Namespace / Create Namespace

```bash
kubectl create namespace mubdi-ai
kubectl config set-context --current --namespace=mubdi-ai
```

#### 7. نشر التطبيق / Deploy Application

```bash
kubectl apply -f deployment/kubernetes.yaml
```

#### 8. مراقبة النشر / Monitor Deployment

```bash
# مراقبة حالة النشر
kubectl get pods -w

# انتظار جاهزية التطبيق
kubectl wait --for=condition=available --timeout=300s deployment/mubdi-ai-backend
kubectl wait --for=condition=available --timeout=300s deployment/mubdi-ai-frontend
```

## التحقق من النشر / Deployment Verification

### 1. فحص الخدمات / Check Services

```bash
kubectl get services
kubectl get pods
kubectl get deployments
```

### 2. فحص السجلات / Check Logs

```bash
# سجلات الواجهة الخلفية
kubectl logs -f deployment/mubdi-ai-backend

# سجلات الواجهة الأمامية
kubectl logs -f deployment/mubdi-ai-frontend
```

### 3. اختبار الصحة / Health Check

```bash
# اختبار صحة الواجهة الخلفية
kubectl port-forward service/mubdi-ai-backend-service 8000:80
curl http://localhost:8000/health

# اختبار صحة الواجهة الأمامية
kubectl port-forward service/mubdi-ai-frontend-service 3000:80
curl http://localhost:3000/health
```

## الوصول للتطبيق / Application Access

### 1. الحصول على عنوان IP الخارجي / Get External IP

```bash
kubectl get service mubdi-ai-frontend-service
```

### 2. إعداد النطاق (اختياري) / Domain Setup (Optional)

```bash
# إعداد DNS للنطاق المخصص
# Setup DNS for custom domain
```

## المراقبة والصيانة / Monitoring and Maintenance

### 1. أوامر المراقبة / Monitoring Commands

```bash
# مراقبة الموارد
kubectl top pods
kubectl top nodes

# مراقبة الأحداث
kubectl get events --sort-by=.metadata.creationTimestamp

# مراقبة Auto-scaling
kubectl get hpa
```

### 2. التحديث / Updates

```bash
# تحديث صورة الواجهة الخلفية
kubectl set image deployment/mubdi-ai-backend backend=gcr.io/mubdiai-470007/mubdi-ai-backend:new-version

# تحديث صورة الواجهة الأمامية
kubectl set image deployment/mubdi-ai-frontend frontend=gcr.io/mubdiai-470007/mubdi-ai-frontend:new-version
```

### 3. النسخ الاحتياطي / Backup

```bash
# نسخ احتياطي للإعدادات
kubectl get all -o yaml > backup-$(date +%Y%m%d).yaml
```

## استكشاف الأخطاء / Troubleshooting

### مشاكل شائعة / Common Issues

#### 1. فشل في بناء الصورة / Image Build Failure
```bash
# فحص سجلات البناء
docker build --no-cache -t image-name .
```

#### 2. فشل في النشر / Deployment Failure
```bash
# فحص أحداث النشر
kubectl describe deployment mubdi-ai-backend
kubectl describe pod <pod-name>
```

#### 3. مشاكل الشبكة / Network Issues
```bash
# فحص الخدمات والشبكة
kubectl get endpoints
kubectl describe service mubdi-ai-backend-service
```

#### 4. مشاكل الصلاحيات / Permission Issues
```bash
# فحص الصلاحيات
kubectl auth can-i create pods
gcloud projects get-iam-policy mubdiai-470007
```

## الأمان / Security

### 1. إعدادات الأمان / Security Settings
- استخدام HTTPS للاتصالات الخارجية
- تشفير المفاتيح في Kubernetes Secrets
- تقييد الوصول للشبكة باستخدام Network Policies

### 2. مراقبة الأمان / Security Monitoring
- مراقبة السجلات للأنشطة المشبوهة
- تحديث الصور بانتظام
- فحص الثغرات الأمنية

## التكلفة والأداء / Cost and Performance

### 1. تحسين التكلفة / Cost Optimization
- استخدام Auto-scaling لتوفير الموارد
- مراقبة استخدام APIs
- تحسين حجم الصور

### 2. تحسين الأداء / Performance Optimization
- استخدام CDN للملفات الثابتة
- تحسين استعلامات قاعدة البيانات
- مراقبة زمن الاستجابة

## الدعم والمساعدة / Support and Help

### الموارد المفيدة / Useful Resources
- [Google Cloud Documentation](https://cloud.google.com/docs)
- [Kubernetes Documentation](https://kubernetes.io/docs)
- [FastAPI Documentation](https://fastapi.tiangolo.com)
- [React Documentation](https://react.dev)

### الاتصال / Contact
للحصول على المساعدة، يرجى التواصل مع فريق التطوير.

For support, please contact the development team.

---

## ملخص الأوامر السريعة / Quick Commands Summary

```bash
# النشر السريع / Quick Deployment
cd mubdi-ai && ./deploy.sh

# مراقبة سريعة / Quick Monitoring
kubectl get all -n mubdi-ai

# اختبار سريع / Quick Test
kubectl port-forward service/mubdi-ai-frontend-service 3000:80
```

---

**تم إنشاء هذا الدليل بواسطة فريق مُبدع AI**
**Created by Mubdi AI Team**
