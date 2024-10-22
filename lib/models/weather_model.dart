// custom data structure to represent the data and maybe hold some functionality
class WeatherModel {
  String? description;
  String? locationName;
  String? weatherStatus;
  int? weatherId;
  double? temp;

  WeatherModel(
      {this.description,
      this.locationName,
      this.weatherStatus,
      this.weatherId,
      this.temp});

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    List list = map['weather'] ?? [];
    return WeatherModel(
      description: list.isNotEmpty ? list.first['description'] : null,
      locationName: map["name"],
      weatherStatus: list.isNotEmpty ? list.first['main'] : null,
      weatherId: list.isNotEmpty ? list.first['id'] : null,
      temp: map["main"]["feels_like"],
    );
  }

  String getWeatherIcon() {
    if (weatherId == null) {
      return '🤷‍';
    }
    if (weatherId! < 300) {
      return '🌩';
    } else if (weatherId! < 400) {
      return '🌧';
    } else if (weatherId! < 600) {
      return '☔️';
    } else if (weatherId! < 700) {
      return '☃️';
    } else if (weatherId! < 800) {
      return '🌫';
    } else if (weatherId == 800) {
      return '☀️';
    } else if (weatherId! <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage() {
    if (temp == null) {
      return "We can't get the weather temperature";
    }
    if (temp! > 25) {
      return 'It\'s 🍦 time';
    } else if (temp! > 20) {
      return 'Time for shorts and 👕';
    } else if (temp! < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
