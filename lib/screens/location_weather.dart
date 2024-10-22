import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kick_gaza_s7/models/weather_model.dart';
import 'package:kick_gaza_s7/services/location_service.dart';

import '../repositories/weather_repository.dart';

class LocationWeather extends StatefulWidget {
  const LocationWeather({super.key, required this.position});

  final Position position;

  @override
  State<LocationWeather> createState() => _LocationWeatherState();
}

class _LocationWeatherState extends State<LocationWeather> {
  WeatherRepository weatherRepository = WeatherRepository();
  WeatherModel? weatherModel;
  bool isLoading = true;

  @override
  void initState() {
    getLocationWeather();
    super.initState();
  }

  void getLocationWeather() async {
    try {
      setState(() {
        isLoading = true;
      });
      weatherModel = await weatherRepository.getLocationWeather(
        latitude: widget.position.latitude,
        longitude: widget.position.longitude,
      );
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.3),
              BlendMode.dstOut,
            ),
            image: AssetImage("assets/images/background.png"),
          ),
        ),
        child: isLoading && weatherModel == null
            ? Center(child: CircularProgressIndicator())
            : Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            weatherModel!.getWeatherIcon(),
                            style: TextStyle(
                              fontSize: 40,
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                weatherModel!.temp?.round().toString() ?? "",
                                style: TextStyle(
                                    fontSize: 60, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "now",
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 4,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 50.0),
                            child: Text(
                              weatherModel!.getMessage(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 60,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (weatherModel!.locationName != null)
                    ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                            width: double.infinity,
                            color: Colors.white.withOpacity(0.1),
                            padding: EdgeInsets.symmetric(
                                vertical: 40, horizontal: 30),
                            child: Text(
                              weatherModel!.locationName!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            )),
                      ),
                    )
                ],
              ),
      ),
      // bottomNavigationBar: weatherModel.locationName != null
      //     ? Container(
      //         color: Colors.white.withOpacity(0.1),
      //         padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
      //         child: Text(
      //           weatherModel.locationName!,
      //           style: TextStyle(
      //             fontWeight: FontWeight.bold,
      //             fontSize: 20,
      //           ),
      //         ))
      //     : null,
    );
  }
}
