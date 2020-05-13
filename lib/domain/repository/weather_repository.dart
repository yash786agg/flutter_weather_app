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
  }) async {
    WeatherData weatherData = await weatherApiClient.fetchWeatherData(
        latitude: latitude, longitude: longitude);

    return weatherData;
  }
}