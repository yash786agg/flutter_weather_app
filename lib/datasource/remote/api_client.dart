import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:weatherapp/datasource/remote/http_exception.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:weatherapp/domain/model/Weather_data.dart';
import 'package:weatherapp/utils/constants.dart';

class WeatherApiClient {
  static const baseUrl = 'http://api.openweathermap.org/data/2.5';
  var logger = Logger();

  WeatherApiClient({
    @required this.apiKey,
    @required this.httpClient,
  }) : assert(apiKey != null, httpClient != null);

  final String apiKey;
  final http.Client httpClient;

  Future<WeatherData> fetchWeatherData({
    @required double latitude,
    @required double longitude,
  }) async {
    final requestedUrl =
        '$baseUrl/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';

    logger.i(Constant.loggerMessage, "fetching:  $requestedUrl");

    final response = await this.httpClient.get(requestedUrl);
    if (response.statusCode != 200)
      throw HTTPException(
          code: response.statusCode, message: "Unable to fetch Weather Data");

    final weatherJson = json.decode(response.body);

    logger.i(Constant.loggerMessage,
        'WeatherData Success: ${weatherJson.toString()}');

    return WeatherData.fromWeatherJson(weatherJson);
  }
}
