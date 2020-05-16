import 'package:flutter/cupertino.dart';
import 'package:weatherapp/datasource/remote/api_client.dart';
import 'package:weatherapp/domain/model/Weather_data.dart';

class WeatherRepository {
  WeatherRepository({
    @required this.weatherApiClient,
  }) : assert(weatherApiClient != null);

  final WeatherApiClient weatherApiClient;

  Future<WeatherData> getWeatherData({
    double latitude,
    double longitude,
    String cityName,
  }) async {
    WeatherData weatherData = await weatherApiClient.fetchWeatherData(
        latitude: latitude, longitude: longitude, cityName: cityName);

    print('getWeatherData weatherData: $weatherData}');

    if (cityName != null) {
      latitude = weatherData.lat;
      longitude = weatherData.lon;
    }

    List<WeatherData> forecast = await weatherApiClient.fetchForecastData(
        latitude: latitude, longitude: longitude);

    print('getWeatherData forecast: $forecast}');

    weatherData.forecastData = forecast;

    return weatherData;
  }
}
