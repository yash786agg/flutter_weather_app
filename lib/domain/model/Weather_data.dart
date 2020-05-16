import 'package:flutter/cupertino.dart';
import 'package:weatherapp/widgets/weather_icons.dart';

class WeatherData {
  var lat;
  var lon;
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
  List<WeatherData> forecastData = [];

  WeatherData({
    this.lat,
    this.lon,
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
    this.forecastData,
  });

  static WeatherData fromWeatherJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    return WeatherData(
      lat: json['coord']['lat'],
      lon: json['coord']['lon'],
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

  static List<WeatherData> fromForecastJson(Map<String, dynamic> json) {
    final forecast = json['list'];
    final weather = List<WeatherData>();
    for (final item in forecast) {
      WeatherData weatherData = WeatherData();
      weatherData.datetime = item['dt'];
      weatherData.temp = item['main']['temp'];
      weatherData.tempIcon = item['weather'][0]['icon'];
      weather.add(weatherData);
    }
    return weather;
  }

  IconData getIconData(tempIcon) {
    switch (tempIcon) {
      case '01d':
        return WeatherIcons.clear_day;
      case '01n':
        return WeatherIcons.clear_night;
      case '02d':
        return WeatherIcons.few_clouds_day;
      case '02n':
        return WeatherIcons.few_clouds_day;
      case '03d':
      case '04d':
        return WeatherIcons.clouds_day;
      case '03n':
      case '04n':
        return WeatherIcons.clear_night;
      case '09d':
        return WeatherIcons.shower_rain_day;
      case '09n':
        return WeatherIcons.shower_rain_night;
      case '10d':
        return WeatherIcons.rain_day;
      case '10n':
        return WeatherIcons.rain_night;
      case '11d':
        return WeatherIcons.thunder_storm_day;
      case '11n':
        return WeatherIcons.thunder_storm_night;
      case '13d':
        return WeatherIcons.snow_day;
      case '13n':
        return WeatherIcons.snow_night;
      case '50d':
        return WeatherIcons.mist_day;
      case '50n':
        return WeatherIcons.mist_night;
      default:
        return WeatherIcons.clear_day;
    }
  }
}
