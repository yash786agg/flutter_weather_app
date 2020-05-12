import 'package:weatherapp/main.dart';

class WeatherData {
  var tempDescription;
  var tempIcon;
  var temp;
  var tempMin;
  var tempMax;
  var name;
  var windSpeed;
  var humidity;
  var datetime;
  var sunrise;
  var sunset;

  WeatherData({
    this.tempDescription,
    this.tempIcon,
    this.tempMin,
    this.tempMax,
    this.temp,
    this.name,
    this.humidity,
    this.windSpeed,
    this.datetime,
    this.sunrise,
    this.sunset,
  });

  static WeatherData fromWeatherJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    return WeatherData(
      tempDescription: weather['main'],
      tempIcon: weather['icon'],
      temp: json['main']['temp'],
      tempMin: json['main']['temp_min'],
      tempMax: json['main']['temp_max'],
      humidity: json['main']['humidity'],
      name: json['name'],
      windSpeed: json['wind']['speed'],
      datetime: json['dt'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
    );
  }
}
