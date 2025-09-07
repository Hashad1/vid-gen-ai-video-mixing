# دليل التثبيت والتشغيل - مُبدع AI

## المتطلبات الأساسية

### 1. متطلبات النظام
- **Python 3.12** أو أحدث
- **Node.js 18** أو أحدث
- **npm** أو **yarn**
- اتصال بالإنترنت

### 2. مفتاح Google AI API

## خطوات التثبيت

### الخطوة 1: تحضير المشروع
## إعداد متغيرات البيئة لتكامل MCP و Gemini

يجب ضبط المتغيرات التالية في البيئة قبل تشغيل الخدمات:

```bash
export GEMINI_API_KEY="AIzaSyD90s6vbzhSYA32UWs8CqIkxC9qcNUzfWc"
export GOOGLE_CLOUD_PROJECT="norse-breaker-462820-s6"
export GOOGLE_CLOUD_LOCATION="us-central1"  # أو المنطقة المناسبة
```

يمكنك إضافتها إلى ملف `.env` أو إلى إعدادات النظام مباشرة.
```bash
# استنساخ المشروع
git clone <repository-url>
cd mubdi-ai

# أو إذا كان لديك المجلد محلياً
cd mubdi-ai
```

### الخطوة 2: إعداد الواجهة الخلفية (Backend)

```bash
# الانتقال إلى مجلد الواجهة الخلفية
cd backend

# تثبيت المتطلبات
pip install -r requirements.txt

# إنشاء ملف متغيرات البيئة
cp .env.example .env

# تحرير ملف .env وإضافة مفتاح API
nano .env
# أو
vim .env
```

**محتوى ملف .env:**
```env
GOOGLE_API_KEY=your_actual_api_key_here
CORS_ORIGINS=http://localhost:3000,http://localhost:5173,http://localhost:12001,http://localhost:12010
HOST=0.0.0.0
PORT=12000
DEBUG=true
LOG_LEVEL=INFO
```

### الخطوة 3: إعداد الواجهة الأمامية (Frontend)

```bash
# الانتقال إلى مجلد الواجهة الأمامية
cd ../frontend

# تثبيت المتطلبات
npm install

# بناء المشروع
npm run build
```

## تشغيل التطبيق

### الطريقة 1: تشغيل منفصل

**تشغيل الواجهة الخلفية:**
```bash
cd backend
python main.py
```
الخدمة ستعمل على: `http://localhost:12000`

**تشغيل الواجهة الأمامية:**
```bash
cd frontend
npm run preview -- --host 0.0.0.0 --port 12001
```
التطبيق سيعمل على: `http://localhost:12001`

### الطريقة 2: تشغيل تلقائي (مستحسن)

```bash
# من المجلد الرئيسي
./start.sh
```

## التحقق من التشغيل

### 1. فحص الواجهة الخلفية
```bash
curl http://localhost:12000/health
```

**النتيجة المتوقعة:**
```json
{
  "status": "healthy",
  "services": {
    "image_generation": "active",
    "video_generation": "active", 
    "text_generation": "active",
    "storyboard_generation": "active"
  }
}
```

### 2. فحص الواجهة الأمامية
افتح المتصفح وانتقل إلى: `http://localhost:12001`

### 3. اختبار شامل
```bash
python test_services.py
```

## الروابط المهمة

- **التطبيق الرئيسي**: http://localhost:12001
- **API الخلفية**: http://localhost:12000
- **وثائق API**: http://localhost:12000/docs
- **فحص الصحة**: http://localhost:12000/health

## استكشاف الأخطاء

### مشكلة: "API key not valid"
**الحل:**
1. تأكد من صحة مفتاح API في ملف `.env`
2. تأكد من تفعيل الخدمات المطلوبة في Google Cloud Console
3. تحقق من حدود الاستخدام في حسابك

### مشكلة: "Port already in use"
**الحل:**
```bash
# إيقاف العمليات على المنفذ 12000
pkill -f "python main.py"

# إيقاف العمليات على المنفذ 12001
pkill -f "npm run preview"

# أو استخدام منافذ مختلفة
python main.py --port 12002
npm run preview -- --port 12003
```

### مشكلة: "Module not found"
**الحل:**
```bash
# للواجهة الخلفية
cd backend
pip install -r requirements.txt

# للواجهة الأمامية
cd frontend
npm install
```

### مشكلة: "CORS error"
**الحل:**
تأكد من إضافة عنوان الواجهة الأمامية إلى `CORS_ORIGINS` في ملف `.env`

## الميزات المتاحة

### 🎨 إنشاء الصور
- نماذج: Imagen 4.0 Ultra
- نسب العرض: مربع، أفقي، عمودي، بانوراما، ستوري
- الأنماط: واقعي، فني، تجاري، سينمائي

### 🎥 إنشاء الفيديوهات  
- نماذج: Veo 2.0
- المدة: 3-30 ثانية
- نسب العرض: متعددة
- الأنماط: سينمائي، تجاري، فني

### 📝 النصوص الإعلانية
- العناوين الجذابة
- الأوصاف التسويقية
- دعوات العمل
- منشورات وسائل التواصل

### 🎬 الستوري بورد
- عدد المشاهد: 3-10
- الأنماط: احترافي، مُبدعي
- التصدير: JSON, TXT

## الدعم

للحصول على المساعدة:
1. راجع ملف `README.md`
2. تحقق من ملفات السجل (logs)
3. افتح Issue في المستودع
4. راجع وثائق Google AI

---

**ملاحظة مهمة:** تأكد من الحصول على مفتاح API صالح من Google AI Studio قبل البدء في الاستخدام.