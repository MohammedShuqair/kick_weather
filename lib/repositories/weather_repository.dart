import 'package:kick_gaza_s7/models/weather_model.dart';

import '../network/network_helper.dart';

/// midpoint between the [NetworkHelper] and the [WeatherModel]
class WeatherRepository {
  Future<WeatherModel?> getLocationWeather({
    required double latitude,
    required double longitude,
  }) async {
    NetworkHelper networkHelper = NetworkHelper(
        "https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=e02ce49e2749377b28bdee125dd1b2a2&units=metric");

    Map<String, dynamic>? data = await networkHelper.getData();
    if (data != null) {
      return WeatherModel.fromMap(data);
    }
    return null;
  }
}
