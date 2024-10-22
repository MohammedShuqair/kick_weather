import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../services/location_service.dart';
import 'location_weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Position? position;
  bool isPermissionGranted = true;

  @override
  void initState() {
    // getLocation
    getLocation();
    super.initState();
  }

  void getLocation() async {
    try {
      position = await LocationService.determinePosition();
      if (mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return LocationWeather(
            position: position!,
          );
        }));
      }
    } catch (e) {
      setState(() {
        isPermissionGranted = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            e.toString(),
          ),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isPermissionGranted
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () async {
                  getLocation();
                },
                child: Text("Give Permission"),
              ),
      ),
    );
  }
}
