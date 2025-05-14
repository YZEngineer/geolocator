📍 geolocator
هذه الوثيقة تشرح كيفية إعداد واستخدام حزمة geolocator في تطبيق Flutter لتحديد الموقع الجغرافي للمستخدم.
✅ خطوات الاستخدام
1. استيراد الحزمة
import 'package:geolocator/geolocator.dart';
<br><>
3. إضافة الحزمة إلى المشروع
flutter pub add geolocator


5. إعداد ملف android/app/build.gradle


android {
    namespace = "com.example.geolocator"
    compileSdk = 35
    ndkVersion = "27.0.12077973"
}
6. إضافة الأذونات في ملف AndroidManifest.xml





<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />


7. التحقق من تفعيل خدمات الموقع




Future<void> myFunction() async {
  bool serviceEnabled;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  print(serviceEnabled);
}



8. استدعاء الدالة في initState


@override
void initState() {
  super.initState();
  myFunction();
}


ℹ️ ملاحظات
يمكنك أيضًا استخدام الدالتين _handleLocationPermission و _getCurrentLocation المتوفرتين في ملف main.dart.
