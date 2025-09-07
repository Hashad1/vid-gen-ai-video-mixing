# دليل النشر - مُبدع AI

## حالة المشروع الحالية ✅

### الخوادم النشطة
- **الواجهة الخلفية**: http://localhost:12000 ✅
- **الواجهة الأمامية**: http://localhost:12010 ✅
- **وثائق API**: http://localhost:12000/docs ✅
- **فحص الصحة**: http://localhost:12000/health ✅

### الخدمات المتاحة
- ✅ إنشاء الصور (Imagen 4.0 Ultra)
- ✅ إنشاء الفيديوهات (Veo 2.0)
- ✅ النصوص الإعلانية (Gemini 2.0 Flash)
- ✅ الستوري بورد المرئي (Gemini 2.0 Flash)

## الوصول للتطبيق

### للمطورين
- **الواجهة الأمامية**: https://work-1-vroifkpmvomgpspp.prod-runtime.all-hands.dev
- **الواجهة الخلفية**: https://work-2-vroifkpmvomgpspp.prod-runtime.all-hands.dev

### محلياً
- **الواجهة الأمامية**: http://localhost:12010
- **الواجهة الخلفية**: http://localhost:12000

## إعدادات البيئة

### متغيرات البيئة المطلوبة
```bash
GOOGLE_API_KEY=AIzaSyDUBYbQq7touDxg6kadjos8BljDflpL4F0
CORS_ORIGINS=http://localhost:3000,http://localhost:5173,https://work-1-vroifkpmvomgpspp.prod-runtime.all-hands.dev,https://work-2-vroifkpmvomgpspp.prod-runtime.all-hands.dev
```

## اختبار الخدمات

### 1. اختبار إنشاء الصور
```bash
curl -X POST "http://localhost:12000/generate-image" \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "منظر طبيعي جميل",
    "aspect_ratio": "16:9",
    "style": "realistic",
    "number_of_images": 1
  }'
```

### 2. اختبار إنشاء الفيديو
```bash
curl -X POST "http://localhost:12000/generate-video" \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "طائر يطير في السماء",
    "duration_seconds": 5,
    "aspect_ratio": "16:9",
    "style": "cinematic"
  }'
```

### 3. اختبار النصوص الإعلانية
```bash
curl -X POST "http://localhost:12000/generate-ad-copy" \
  -H "Content-Type: application/json" \
  -d '{
    "product_name": "هاتف ذكي",
    "product_description": "هاتف بمواصفات عالية",
    "target_audience": "الشباب",
    "tone": "professional"
  }'
```

### 4. اختبار الستوري بورد
```bash
curl -X POST "http://localhost:12000/generate-storyboard" \
  -H "Content-Type: application/json" \
  -d '{
    "concept": "إعلان منتج جديد",
    "num_scenes": 5,
    "style": "professional",
    "duration": "30s"
  }'
```

## إعادة التشغيل

### إعادة تشغيل الواجهة الخلفية
```bash
cd /workspace/mubdi-ai/backend
pkill -f "python.*main.py"
python main.py > backend.log 2>&1 &
```

### إعادة تشغيل الواجهة الأمامية
```bash
cd /workspace/mubdi-ai/frontend
pkill -f "npm.*preview"
npm run preview -- --host 0.0.0.0 --port 12001 > frontend.log 2>&1 &
```

## مراقبة السجلات

### سجلات الواجهة الخلفية
```bash
cd /workspace/mubdi-ai/backend
tail -f backend.log
```

### سجلات الواجهة الأمامية
```bash
cd /workspace/mubdi-ai/frontend
tail -f nohup.out
```

## استكشاف الأخطاء

### مشاكل شائعة وحلولها

#### 1. خطأ في مفتاح API
```bash
# تحقق من وجود المفتاح
cat /workspace/mubdi-ai/backend/.env
# يجب أن يحتوي على: GOOGLE_API_KEY=AIzaSyDUBYbQq7touDxg6kadjos8BljDflpL4F0
```

#### 2. مشكلة في المنافذ
```bash
# تحقق من المنافذ المستخدمة
ps aux | grep -E "(python|npm)"
```

#### 3. مشاكل CORS
```bash
# تحقق من إعدادات CORS في .env
grep CORS_ORIGINS /workspace/mubdi-ai/backend/.env
```

## النسخ الاحتياطي

### نسخ احتياطي للمشروع
```bash
cd /workspace
tar -czf mubdi-ai-backup-$(date +%Y%m%d).tar.gz mubdi-ai/
```

### استعادة من النسخة الاحتياطية
```bash
cd /workspace
tar -xzf mubdi-ai-backup-YYYYMMDD.tar.gz
```

## الأمان

### نصائح أمنية
1. **لا تشارك مفتاح API** في الكود المصدري
2. **استخدم HTTPS** في الإنتاج
3. **قم بتحديث المكتبات** بانتظام
4. **راقب الاستخدام** لتجنب تجاوز الحدود

## الدعم الفني

### معلومات الاتصال
- **المطور**: OpenHands AI Assistant
- **التاريخ**: 2025-07-21
- **الإصدار**: v2.0.0

### الملفات المهمة
- `/workspace/mubdi-ai/backend/main.py` - الخادم الرئيسي
- `/workspace/mubdi-ai/backend/.env` - متغيرات البيئة
- `/workspace/mubdi-ai/frontend/src/App.tsx` - التطبيق الأمامي
- `/workspace/mubdi-ai/README.md` - الوثائق الرئيسية

---

**ملاحظة**: هذا المشروع يستخدم أحدث تقنيات Google AI ويتطلب مفتاح API صالح للعمل بشكل صحيح.