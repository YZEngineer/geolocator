import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'موقعي',
      home: const LocationPage(title: 'الموقع'),
    );
  }
}

class LocationPage extends StatefulWidget {
  const LocationPage({super.key, required this.title});
  final String title;
  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Position? _currentPosition;
  String _locationMessage = "Fetching location...";
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = 'الخدمات غير مفعلة';
        _isLoading = false;
      });
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      //  لا يوجد اذن للموقع
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationMessage = 'الرجاء السماح بالموقع';
          _isLoading = false;
        });
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage = ' الموقع غير مسموح به';
        _isLoading = false;
      });
      return false;
    }

    return true;
  }

  Future<void> _getCurrentLocation() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;

    try {
      setState(() {
        _isLoading = true;
        _locationMessage = 'جاري تحديد الموقع...';
      });

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
        timeLimit: const Duration(seconds: 15),
      );

      setState(() {
        _currentPosition = position;
        _locationMessage = '';
        _isLoading = false;
      });
    } catch (e) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium,
        );

        setState(() {
          _currentPosition = position;
          _locationMessage = 'تم الحصول على الموقع بدقة متوسطة.';
          _isLoading = false;
        });
      } catch (e) {
        setState(() {
          _locationMessage = 'خطأ في تحديد الموقع: $e';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          children: <Widget>[
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_locationMessage.isNotEmpty)
              Text(
                _locationMessage,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              )
            else if (_currentPosition != null)
              Column(
                children: [
                  const Text(
                    'الموقع الحالي:',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 20),
                  Text(
                    'خط العرض: ${_currentPosition!.latitude.toStringAsFixed(6)}',
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 10),
                  Text(
                    'خط الطول: ${_currentPosition!.longitude.toStringAsFixed(6)}',
                    style: const TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 10),
                  Text(
                    'الدقة: ${_currentPosition!.accuracy.toStringAsFixed(1)} متر',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getCurrentLocation,
        tooltip: 'Get Location',
        child: const Icon(Icons.location_searching),
      ),
    );
  }
}
