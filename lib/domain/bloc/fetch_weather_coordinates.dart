import 'package:flutter/cupertino.dart';

class FetchWeather {
  FetchWeather({
    @required this.latitude,
    @required this.longitude,
  }) : assert(latitude != null && longitude != null);

  final double latitude;
  final double longitude;
}
