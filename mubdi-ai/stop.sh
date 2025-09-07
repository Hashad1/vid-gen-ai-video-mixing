#!/bin/bash

# ملف إيقاف تطبيق مُبدع AI
# يقوم بإيقاف الواجهة الخلفية والأمامية

echo "🛑 إيقاف تطبيق مُبدع AI..."

# الحصول على مسار المجلد الحالي
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# إيقاف الخادم الخلفي
if [ -f "$SCRIPT_DIR/.backend_pid" ]; then
    BACKEND_PID=$(cat "$SCRIPT_DIR/.backend_pid")
    if kill -0 $BACKEND_PID 2>/dev/null; then
        echo "إيقاف الخادم الخلفي (PID: $BACKEND_PID)..."
        kill $BACKEND_PID
        echo "✅ تم إيقاف الخادم الخلفي"
    else
        echo "⚠️ الخادم الخلفي غير يعمل"
    fi
    rm -f "$SCRIPT_DIR/.backend_pid"
else
    echo "⚠️ لم يتم العثور على ملف PID للخادم الخلفي"
fi

# إيقاف الخادم الأمامي
if [ -f "$SCRIPT_DIR/.frontend_pid" ]; then
    FRONTEND_PID=$(cat "$SCRIPT_DIR/.frontend_pid")
    if kill -0 $FRONTEND_PID 2>/dev/null; then
        echo "إيقاف الخادم الأمامي (PID: $FRONTEND_PID)..."
        kill $FRONTEND_PID
        echo "✅ تم إيقاف الخادم الأمامي"
    else
        echo "⚠️ الخادم الأمامي غير يعمل"
    fi
    rm -f "$SCRIPT_DIR/.frontend_pid"
else
    echo "⚠️ لم يتم العثور على ملف PID للخادم الأمامي"
fi

# البحث عن أي عمليات متبقية
echo "البحث عن عمليات متبقية..."
BACKEND_PROCESSES=$(pgrep -f "python main.py" || true)
FRONTEND_PROCESSES=$(pgrep -f "vite" || true)

if [ ! -z "$BACKEND_PROCESSES" ]; then
    echo "إيقاف عمليات Python المتبقية..."
    echo "$BACKEND_PROCESSES" | xargs kill -9 2>/dev/null || true
fi

if [ ! -z "$FRONTEND_PROCESSES" ]; then
    echo "إيقاف عمليات Vite المتبقية..."
    echo "$FRONTEND_PROCESSES" | xargs kill -9 2>/dev/null || true
fi

echo "✅ تم إيقاف جميع العمليات"
