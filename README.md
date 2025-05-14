# geolocator

- [الخطوات موجودة هنا] (https://pub.dev/packages/geolocator)


* 

- 
1- import 'package:geolocator/geolocator.dart';
* 
2- flutter pub add geolocator
* 
3-  android {
    namespace = "com.example.geolocator"
    compileSdk = 35
    ndkVersion = "27.0.12077973"
 ... 

4-      <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
- 
/*  اختياري ...  
    android {
        namespace = "com.example.geolocator"
        compileSdk = 35
        ndkVersion = "27.0.12077973"
    */

5- myFunction  async { bool serviceEnab1ed; 
  LocationPermission
  serviceEnab1ed = await Geolocator.isLocationServiceEnab1ed();
  print(serviceEnable);
  }
- 
  
@override
void initState() {
myFunction( ) ;
.... 
-

ويمكنك استعمال  _handleLocationPermission و _getCurrentLocation الموجود في ملف main.dart
- 
