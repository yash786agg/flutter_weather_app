import 'package:flutter/material.dart';
import 'package:weatherapp/screens/todays_weather.dart';

void main() => runApp(
      MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => TodayWeather(),
        },
      ),
    );
