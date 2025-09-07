# مُبدع AI - صناعة الفيديو والصور بالذكاء الاصطناعي

تطبيق شامل لإنشاء المحتوى المرئي باستخدام الذكاء الاصطناعي، يتكون من واجهة خلفية بـ Python وواجهة أمامية بـ React.

## المميزات

### 🎨 إنشاء الصور
- إنشاء صور عالية الجودة من النصوص
- دعم رفع صور مرجعية
- خيارات متنوعة للأحجام والزوايا
- تحليل الصور تلقائياً
- إنشاء نصوص إعلانية

### 🎬 ستوري بورد مرئي
- إنشاء ستوري بورد متكامل للفيديوهات
- تحديد عدد المشاهد
- وصف تفصيلي لكل مشهد
- تحميل النصوص

### 🎥 صناعة الفيديو
- إنشاء فيديوهات قصيرة
- تحديد المدة المطلوبة
- دعم الصور المرجعية
- معاينة وتحميل

### ✨ مميزات إضافية
- مكتبة برومبتات جاهزة
- اقتراحات مُبدعية تلقائية
- واجهة عربية RTL
- تصميم متجاوب
- دعم التعرف على الصوت

## التقنيات المستخدمة

### الواجهة الخلفية (Backend)
- **Python 3.12**
- **FastAPI** - إطار عمل سريع لبناء APIs
- **Google Generative AI** - للذكاء الاصطناعي
- **Pillow** - معالجة الصور
- **Uvicorn** - خادم ASGI

### الواجهة الأمامية (Frontend)
- **React 18** مع **TypeScript**
- **Vite** - أداة البناء
- **Tailwind CSS** - للتصميم
- **Axios** - للتواصل مع API
- **Cairo Font** - خط عربي

## التثبيت والتشغيل

### متطلبات النظام
- Node.js 18+
- Python 3.12+
- مفتاح API من Google Gemini

### 1. إعداد الواجهة الخلفية

```bash
cd backend
pip install -r requirements.txt
```

إنشاء ملف `.env`:
```env
GEMINI_API_KEY=your_gemini_api_key_here
CORS_ORIGINS=http://localhost:3000,http://localhost:5173,https://work-1-vroifkpmvomgpspp.prod-runtime.all-hands.dev,https://work-2-vroifkpmvomgpspp.prod-runtime.all-hands.dev
```

تشغيل الخادم:
```bash
python main.py
```

الخادم سيعمل على: `http://localhost:12000`

### 2. إعداد الواجهة الأمامية

```bash
cd frontend
npm install
npm run dev
```

التطبيق سيعمل على: `http://localhost:12001`

## هيكل المشروع

```
mubdi-ai/
├── backend/
│   ├── main.py              # الخادم الرئيسي
│   ├── requirements.txt     # متطلبات Python
│   ├── .env                 # متغيرات البيئة
│   └── .env.example         # مثال لمتغيرات البيئة
├── frontend/
│   ├── src/
│   │   ├── components/      # مكونات React
│   │   │   ├── Header.tsx
│   │   │   ├── HeroSection.tsx
│   │   │   ├── ServicesSection.tsx
│   │   │   ├── GeneratorSection.tsx
│   │   │   ├── ImageGenerator.tsx
│   │   │   ├── StoryboardGenerator.tsx
│   │   │   └── VideoGenerator.tsx
│   │   ├── services/
│   │   │   └── api.ts       # خدمات API
│   │   ├── App.tsx          # المكون الرئيسي
│   │   ├── main.tsx         # نقطة الدخول
│   │   └── index.css        # الأنماط
│   ├── package.json
│   ├── vite.config.ts
│   └── index.html
└── README.md
```

## API Endpoints

### الصور
- `POST /api/generate-image` - إنشاء صورة
- `POST /api/analyze-image` - تحليل صورة
- `POST /api/generate-ad-copy` - إنشاء نص إعلاني

### الفيديو
- `POST /api/generate-storyboard` - إنشاء ستوري بورد
- `POST /api/generate-video` - إنشاء فيديو

### المساعدة
- `POST /api/magic-prompt` - اقتراح أفكار مُبدعية
- `GET /api/prompt-library` - مكتبة البرومبتات

## الاستخدام

1. **إنشاء صورة:**
   - اختر تبويب "إنشاء صورة"
   - ارفع صورة مرجعية (اختياري)
   - اكتب وصف الصورة المطلوبة
   - اختر الحجم وزاوية الكاميرا
   - اضغط "إنشاء الصورة"

2. **ستوري بورد مرئي:**
   - اختر تبويب "ستوري بورد مرئي"
   - اكتب فكرة الفيديو
   - حدد عدد المشاهد
   - اضغط "إنشاء الستوري بورد"

3. **صناعة فيديو:**
   - اختر تبويب "صناعة فيديو"
   - اكتب وصف الفيديو
   - حدد المدة المطلوبة
   - اضغط "إنشاء الفيديو"

## المساهمة

نرحب بالمساهمات! يرجى:

1. عمل Fork للمشروع
2. إنشاء فرع جديد للميزة
3. إجراء التغييرات
4. إرسال Pull Request

## الترخيص

هذا المشروع مرخص تحت رخصة MIT.

## الدعم

للحصول على الدعم أو الإبلاغ عن مشاكل، يرجى إنشاء Issue في المستودع.

---

**ملاحظة:** هذا التطبيق يستخدم Google Gemini AI لإنشاء المحتوى. تأكد من الحصول على مفتاح API صالح من Google AI Studio.