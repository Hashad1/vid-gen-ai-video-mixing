#!/usr/bin/env python3
"""
اختبار شامل لجميع خدمات مُبدع AI
"""

import requests
import json
import time
import base64
from pathlib import Path

# إعدادات الاختبار
BASE_URL = "http://localhost:12000"
API_V1_URL = f"{BASE_URL}/api/v1"
TEST_IMAGE_PATH = "test_image.jpg"

def test_health_check():
    """اختبار فحص الصحة"""
    print("🔍 اختبار فحص الصحة...")
    try:
        response = requests.get(f"{BASE_URL}/health")
        if response.status_code == 200:
            data = response.json()
            print(f"✅ الخدمة تعمل بشكل صحيح: {data}")
            return True
        else:
            print(f"❌ خطأ في فحص الصحة: {response.status_code}")
            return False
    except Exception as e:
        print(f"❌ خطأ في الاتصال: {e}")
        return False


def test_ad_copy_generation():
    """اختبار إنشاء النصوص الإعلانية"""
    print("\n📝 اختبار إنشاء النصوص الإعلانية...")
    try:
        payload = {
            "product_name": "هاتف ذكي متطور",
            "product_description": "هاتف ذكي بكاميرا عالية الدقة وبطارية تدوم طويلاً",
            "target_audience": "الشباب المهتمون بالتكنولوجيا",
            "tone": "professional"
        }
        
        response = requests.post(f"{API_V1_URL}/ad-copy/generate-ad-copy", json=payload)
        if response.status_code == 200:
            data = response.json()
            if data.get("success"):
                print("✅ تم إنشاء النصوص الإعلانية بنجاح")
                print(f"   - عناوين: {len(data.get('headlines', []))}")
                print(f"   - أوصاف: {len(data.get('descriptions', []))}")
                print(f"   - دعوات للعمل: {len(data.get('call_to_actions', []))}")
                return True
            else:
                print(f"❌ فشل في إنشاء النصوص: {data.get('error')}")
                return False
        else:
            print(f"❌ خطأ HTTP: {response.status_code}")
            return False
    except Exception as e:
        print(f"❌ خطأ في إنشاء النصوص الإعلانية: {e}")
        return False

def test_storyboard_generation():
    """اختبار إنشاء الستوري بورد"""
    print("\n🎬 اختبار إنشاء الستوري بورد...")
    try:
        payload = {
            "concept": "إعلان لمنتج تقني جديد يظهر رحلة المستخدم من الاكتشاف إلى الاستخدام",
            "num_scenes": 4,
            "style": "professional",
            "duration": "30s"
        }
        
        response = requests.post(f"{API_V1_URL}/storyboard/generate-storyboard", json=payload)
        if response.status_code == 200:
            data = response.json()
            if data.get("success"):
                print(f"✅ تم إنشاء ستوري بورد بـ {len(data.get('scenes', []))} مشهد")
                return True
            else:
                print(f"❌ فشل في إنشاء الستوري بورد: {data.get('error')}")
                return False
        else:
            print(f"❌ خطأ HTTP: {response.status_code}")
            return False
    except Exception as e:
        print(f"❌ خطأ في إنشاء الستوري بورد: {e}")
        return False

def test_prompt_ideas():
    """اختبار توليد أفكار للموجهات"""
    print("\n✨ اختبار توليد أفكار للموجهات...")
    try:
        payload = {
            "topic": "التسويق الرقمي",
            "service": "ad_copy"
        }
        response = requests.post(f"{API_V1_URL}/prompt/ideas", json=payload)
        if response.status_code == 200:
            data = response.json()
            if data.get("success"):
                print(f"✅ تم إنشاء {len(data.get('ideas', []))} فكرة بنجاح")
                return True
            else:
                print(f"❌ فشل في توليد الأفكار: {data.get('error')}")
                return False
        else:
            print(f"❌ خطأ HTTP: {response.status_code}")
            return False
    except Exception as e:
        print(f"❌ خطأ في توليد الأفكار: {e}")
        return False

def test_style_options():
    """اختبار خيارات الأنماط"""
    print("\n🎭 اختبار خيارات الأنماط...")
    try:
        # اختبار أنماط الصور
        response = requests.get(f"{API_V1_URL}/settings/image-styles")
        if response.status_code == 200:
            styles = response.json()
            print(f"✅ تم تحميل {len(styles)} نمط للصور")
        else:
            print(f"❌ خطأ في تحميل أنماط الصور: {response.status_code}")
            return False
        
        # اختبار أنماط الفيديو
        response = requests.get(f"{API_V1_URL}/settings/storyboard-styles")
        if response.status_code == 200:
            styles = response.json()
            print(f"✅ تم تحميل {len(styles)} نمط للستوري بورد")
        else:
            print(f"❌ خطأ في تحميل أنماط الفيديو: {response.status_code}")
            return False
        
        return True
    except Exception as e:
        print(f"❌ خطأ في اختبار الأنماط: {e}")
        return False

def run_all_tests():
    """تشغيل جميع الاختبارات"""
    print("🚀 بدء اختبار جميع خدمات مُبدع AI")
    print("=" * 50)
    
    tests = [
        ("فحص الصحة", test_health_check),
        ("النصوص الإعلانية", test_ad_copy_generation),
        ("الستوري بورد", test_storyboard_generation),
        ("توليد الأفكار", test_prompt_ideas),
        ("خيارات الأنماط", test_style_options),
    ]
    
    results = []
    for test_name, test_func in tests:
        try:
            result = test_func()
            results.append((test_name, result))
            time.sleep(1)  # فترة انتظار بين الاختبارات
        except Exception as e:
            print(f"❌ خطأ في اختبار {test_name}: {e}")
            results.append((test_name, False))
    
    # عرض النتائج النهائية
    print("\n" + "=" * 50)
    print("📊 نتائج الاختبارات:")
    print("=" * 50)
    
    passed = 0
    total = len(results)
    
    for test_name, result in results:
        status = "✅ نجح" if result else "❌ فشل"
        print(f"{status} - {test_name}")
        if result:
            passed += 1
    
    print("=" * 50)
    print(f"📈 النتيجة النهائية: {passed}/{total} اختبار نجح ({passed/total*100:.1f}%)")
    
    if passed == total:
        print("🎉 جميع الاختبارات نجحت! المنصة تعمل بشكل مثالي.")
    else:
        print("⚠️  بعض الاختبارات فشلت. يرجى مراجعة الأخطاء أعلاه.")
    
    return passed == total

if __name__ == "__main__":
    success = run_all_tests()
    exit(0 if success else 1)