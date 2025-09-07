#!/bin/bash

# Change to the mubdi-ai directory
cd "$(dirname "$0")"

echo "🚀 بدء تشغيل مُبدع AI..."
echo "=================================="

# التحقق من المتطلبات الأساسية
check_dependency() {
    if ! command -v $1 &> /dev/null; then
        echo "❌ $1 غير مثبت. يرجى تثبيته."
        exit 1
    fi
}

check_dependency python3
check_dependency node
check_dependency npm

# التحقق من ملف .env
if [ ! -f "backend/.env" ]; then
    echo "⚠️  ملف .env غير موجود. سيتم إنشاؤه..."
    cp backend/.env.example backend/.env
    echo "📝 تم إنشاء ملف .env. يرجى تحديث GOOGLE_API_KEY."
fi

# إيقاف أي عمليات سابقة
echo "🛑 إيقاف العمليات السابقة..."
pkill -f "python.*main.py" 2>/dev/null || true
pkill -f "npm.*preview" 2>/dev/null || true
sleep 2

# 🧠 إعداد الواجهة الخلفية
echo "📦 إعداد الواجهة الخلفية..."
cd backend

# Force a clean virtual environment to resolve dependency conflicts
echo "🗑️ إزالة البيئة الافتراضية القديمة..."
rm -rf .venv
echo "🔧 إنشاء بيئة افتراضية جديدة..."
python3 -m venv .venv

# التحقق من وجود pip داخل البيئة
if [ ! -f ".venv/bin/pip" ]; then
    echo "❌ pip غير متوفر في البيئة. تأكد من تثبيت venv بشكل صحيح."
    exit 1
fi

# تفعيل البيئة
source .venv/bin/activate

# Always install dependencies to ensure consistency
echo "📦 تثبيت الحزم المطلوبة..."
pip install -r requirements.txt

# تشغيل backend
echo "🔧 تشغيل الواجهة الخلفية..."
# تشغيل backend
echo "🔧 تشغيل الواجهة الخلفية..."
nohup python main.py > ../backend.log 2>&1 &
BACKEND_PID=$!
cd ..

# انتظار جاهزية backend
echo "⏳ انتظار الواجهة الخلفية..."
for i in {1..30}; do
    if curl -s http://localhost:12000/health > /dev/null; then
        echo "✅ الواجهة الخلفية تعمل على http://localhost:12000"
        break
    fi
    sleep 1
    [ $i -eq 30 ] && echo "❌ فشل تشغيل الواجهة الخلفية." && exit 1
done

# 🧠 إعداد الواجهة الأمامية
echo "📦 إعداد الواجهة الأمامية..."
cd frontend
if [ ! -d "node_modules" ]; then
    echo "📥 تثبيت حزم npm..."
    npm install --silent
else
    echo "✅ حزم npm موجودة."
fi

echo "🧹 Clearing Vite cache..."
rm -rf frontend/node_modules/.vite
echo "🔨 بناء الواجهة الأمامية..."
npm run build --silent

# تشغيل frontend
echo "🌐 تشغيل الواجهة الأمامية..."
nohup npm run preview -- --host 0.0.0.0 --port 12001 > ../frontend.log 2>&1 &
FRONTEND_PID=$!
cd ..

# انتظار جاهزية frontend
echo "⏳ انتظار الواجهة الأمامية..."
for i in {1..30}; do
    if curl -s http://localhost:12001 > /dev/null; then
        echo "✅ الواجهة الأمامية تعمل على http://localhost:12001"
        break
    fi
    sleep 1
    [ $i -eq 30 ] && echo "❌ فشل تشغيل الواجهة الأمامية." && exit 1
done

# 💡 عرض النتائج
echo ""
echo "🎉 تم تشغيل مُبدع AI بنجاح!"
echo "=================================="
echo "🔗 http://localhost:12001  ← التطبيق"
echo "🔧 http://localhost:12000  ← الواجهة الخلفية"
echo "📚 http://localhost:12000/docs ← توثيق API"
echo "❤️ http://localhost:12000/health ← فحص الصحة"
echo ""
echo "📋 معرفات العمليات:"
echo "   Backend PID: $BACKEND_PID"
echo "   Frontend PID: $FRONTEND_PID"
echo ""
echo "📝 ملفات السجل:"
echo "   backend.log"
echo "   frontend.log"
echo ""
echo "🛑 لإيقاف التطبيق:"
echo "   ./stop.sh"
echo "   أو: kill $BACKEND_PID $FRONTEND_PID"
echo ""

# حفظ المعرفات
echo "$BACKEND_PID" > .backend_pid
echo "$FRONTEND_PID" > .frontend_pid