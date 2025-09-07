# دليل النشر - مُبدع AI

## حالة التطبيق الحالية

### الخوادم النشطة:
- **الواجهة الخلفية (Backend)**: `http://localhost:12000`
- **الواجهة الأمامية (Frontend)**: `http://localhost:12006`

### الروابط المتاحة:
- **Backend API**: https://work-1-vroifkpmvomgpspp.prod-runtime.all-hands.dev
- **Frontend App**: https://work-2-vroifkpmvomgpspp.prod-runtime.all-hands.dev

## طرق التشغيل

### 1. التشغيل المحلي

#### الواجهة الخلفية:
```bash
cd backend
pip install -r requirements.txt
python main.py
```

#### الواجهة الأمامية:
```bash
cd frontend
npm install
npm run build
cd dist
python -m http.server 12001 --bind 0.0.0.0
```

### 2. التشغيل باستخدام Docker

```bash
# بناء الحاويات
docker-compose build

# تشغيل التطبيق
docker-compose up -d

# إيقاف التطبيق
docker-compose down
```

### 3. التشغيل السريع

```bash
# تثبيت جميع التبعيات
npm run install:all

# تشغيل كلا الخادمين
npm run dev
```

## متطلبات البيئة

### ملف .env للواجهة الخلفية:
```env
GEMINI_API_KEY=your_gemini_api_key_here
CORS_ORIGINS=http://localhost:3000,http://localhost:5173,https://work-1-vroifkpmvomgpspp.prod-runtime.all-hands.dev,https://work-2-vroifkpmvomgpspp.prod-runtime.all-hands.dev
```

### متغيرات البيئة للواجهة الأمامية:
```env
VITE_API_URL=http://localhost:12000
```

## اختبار التطبيق

### اختبار الواجهة الخلفية:
```bash
curl http://localhost:12000/
# النتيجة المتوقعة: {"message":"مُبدع AI Backend is running!"}
```

### اختبار الواجهة الأمامية:
```bash
curl -I http://localhost:12006/
# النتيجة المتوقعة: HTTP/1.0 200 OK
```

## المميزات المتاحة

### ✅ مكتملة:
- إنشاء الصور بالذكاء الاصطناعي
- ستوري بورد مرئي
- صناعة الفيديو
- تحليل الصور
- إنشاء النصوص الإعلانية
- الاقتراحات المُبدعية
- واجهة عربية RTL
- تصميم متجاوب

### 🔧 قيد التطوير:
- مكتبة البرومبتات
- حفظ المشاريع
- مشاركة المحتوى
- تحسين الأداء

## الأمان

- تأكد من إعداد مفتاح Gemini API بشكل صحيح
- لا تشارك ملف .env في المستودعات العامة
- استخدم HTTPS في الإنتاج

## الدعم الفني

للحصول على المساعدة:
1. تحقق من ملفات السجل
2. تأكد من تشغيل جميع الخدمات
3. تحقق من متغيرات البيئة
4. راجع وثائق API

## ملاحظات مهمة

- التطبيق يتطلب اتصال بالإنترنت للذكاء الاصطناعي
- بعض المميزات قد تستغرق وقتاً أطول حسب حجم المحتوى
- تأكد من وجود مساحة كافية لحفظ الملفات المُنشأة