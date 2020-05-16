import 'package:flutter/cupertino.dart';

class FetchWeather {
  FetchWeather({
    this.latitude,
    this.longitude,
    this.cityName,
  }) : assert(latitude != null || longitude != null || cityName != null);

  final double latitude;
  final double longitude;
  final String cityName;
}
