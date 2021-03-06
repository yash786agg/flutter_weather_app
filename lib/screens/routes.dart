import 'package:flutter/material.dart';
import 'package:weatherapp/screens/weather_screen.dart';
import 'package:weatherapp/screens/setting_screen.dart';

class Routes {
  static final mainRoute = <String, WidgetBuilder>{
    '/home': (context) => WeatherScreen(),
    '/settings': (context) => SettingScreen(),
  };
}
