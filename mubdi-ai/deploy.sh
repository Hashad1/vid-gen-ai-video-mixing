#!/bin/bash

# مُبدع AI - سكريبت النشر على Google Cloud
# Mubdi AI - Google Cloud Deployment Script

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Project Configuration
PROJECT_ID="mubdiai-470007"
REGION="us-central1"
CLUSTER_NAME="autopilot-cluster-mubdi"
BACKEND_IMAGE="gcr.io/${PROJECT_ID}/mubdi-ai-backend"
FRONTEND_IMAGE="gcr.io/${PROJECT_ID}/mubdi-ai-frontend"

echo -e "${BLUE}🚀 بدء نشر مشروع مُبدع AI على Google Cloud${NC}"
echo -e "${BLUE}🚀 Starting Mubdi AI deployment to Google Cloud${NC}"

# Function to print step
print_step() {
    echo -e "\n${YELLOW}📋 $1${NC}"
}

# Function to print success
print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

# Function to print error
print_error() {
    echo -e "${RED}❌ $1${NC}"
}

# Step 1: Setup Google Cloud Authentication
print_step "إعداد المصادقة مع Google Cloud"
print_step "Setting up Google Cloud Authentication"

if [ -f "application_default_credentials.json" ]; then
    export GOOGLE_APPLICATION_CREDENTIALS="$(pwd)/application_default_credentials.json"
    gcloud auth activate-service-account --key-file=application_default_credentials.json
    print_success "تم تفعيل حساب الخدمة بنجاح"
else
    print_error "ملف application_default_credentials.json غير موجود"
    exit 1
fi

# Set project
gcloud config set project $PROJECT_ID
print_success "تم تعيين المشروع: $PROJECT_ID"

# Step 2: Enable required APIs
print_step "تفعيل APIs المطلوبة"
print_step "Enabling required APIs"

APIS=(
    "container.googleapis.com"
    "containerregistry.googleapis.com"
    "cloudbuild.googleapis.com"
    "aiplatform.googleapis.com"
    "generativelanguage.googleapis.com"
    "texttospeech.googleapis.com"
    "storage.googleapis.com"
)

for api in "${APIS[@]}"; do
    echo "تفعيل $api..."
    gcloud services enable $api --quiet
done

print_success "تم تفعيل جميع APIs المطلوبة"

# Step 3: Configure Docker for GCR
print_step "إعداد Docker للعمل مع Google Container Registry"
print_step "Configuring Docker for Google Container Registry"

gcloud auth configure-docker --quiet
print_success "تم إعداد Docker بنجاح"

# Step 4: Build Backend Docker Image
print_step "بناء صورة Docker للواجهة الخلفية"
print_step "Building Backend Docker Image"

cd backend
docker build -t $BACKEND_IMAGE:latest .
docker push $BACKEND_IMAGE:latest
cd ..

print_success "تم بناء ورفع صورة الواجهة الخلفية بنجاح"

# Step 5: Build Frontend Docker Image
print_step "بناء صورة Docker للواجهة الأمامية"
print_step "Building Frontend Docker Image"

cd frontend
docker build -t $FRONTEND_IMAGE:latest .
docker push $FRONTEND_IMAGE:latest
cd ..

print_success "تم بناء ورفع صورة الواجهة الأمامية بنجاح"

# Step 6: Connect to GKE Cluster
print_step "الاتصال بـ Kubernetes Cluster"
print_step "Connecting to Kubernetes Cluster"

gcloud container clusters get-credentials $CLUSTER_NAME --region $REGION --project $PROJECT_ID
print_success "تم الاتصال بـ Cluster بنجاح"

# Step 7: Create namespace (if not exists)
print_step "إنشاء Namespace"
print_step "Creating Namespace"

kubectl create namespace mubdi-ai --dry-run=client -o yaml | kubectl apply -f -
kubectl config set-context --current --namespace=mubdi-ai
print_success "تم إعداد Namespace بنجاح"

# Step 8: Deploy to Kubernetes
print_step "نشر التطبيق على Kubernetes"
print_step "Deploying to Kubernetes"

kubectl apply -f deployment/kubernetes.yaml
print_success "تم نشر التطبيق بنجاح"

# Step 9: Wait for deployments to be ready
print_step "انتظار جاهزية التطبيق"
print_step "Waiting for deployments to be ready"

kubectl wait --for=condition=available --timeout=300s deployment/mubdi-ai-backend
kubectl wait --for=condition=available --timeout=300s deployment/mubdi-ai-frontend

print_success "التطبيق جاهز للاستخدام"

# Step 10: Get service information
print_step "معلومات الخدمات"
print_step "Service Information"

echo -e "\n${BLUE}📊 معلومات الخدمات / Service Information:${NC}"
kubectl get services
kubectl get pods
kubectl get ingress

# Step 11: Get external IP (if available)
print_step "الحصول على عنوان IP الخارجي"
print_step "Getting External IP"

EXTERNAL_IP=$(kubectl get service mubdi-ai-frontend-service -o jsonpath='{.status.loadBalancer.ingress[0].ip}' 2>/dev/null || echo "pending")

if [ "$EXTERNAL_IP" != "pending" ] && [ "$EXTERNAL_IP" != "" ]; then
    echo -e "${GREEN}🌐 التطبيق متاح على: http://$EXTERNAL_IP${NC}"
    echo -e "${GREEN}🌐 Application available at: http://$EXTERNAL_IP${NC}"
else
    echo -e "${YELLOW}⏳ عنوان IP الخارجي قيد الإعداد، يرجى المحاولة لاحقاً${NC}"
    echo -e "${YELLOW}⏳ External IP is being provisioned, please check later${NC}"
fi

# Step 12: Show useful commands
print_step "أوامر مفيدة"
print_step "Useful Commands"

echo -e "\n${BLUE}📝 أوامر مفيدة للمراقبة / Useful monitoring commands:${NC}"
echo "kubectl get pods -n mubdi-ai"
echo "kubectl logs -f deployment/mubdi-ai-backend -n mubdi-ai"
echo "kubectl logs -f deployment/mubdi-ai-frontend -n mubdi-ai"
echo "kubectl describe service mubdi-ai-frontend-service -n mubdi-ai"

print_success "تم النشر بنجاح! 🎉"
print_success "Deployment completed successfully! 🎉"

echo -e "\n${GREEN}🎊 مبروك! تم نشر مُبدع AI بنجاح على Google Cloud${NC}"
echo -e "${GREEN}🎊 Congratulations! Mubdi AI has been successfully deployed to Google Cloud${NC}"
