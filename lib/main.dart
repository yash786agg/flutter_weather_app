import 'package:flutter/material.dart';
import 'package:weatherapp/screens/routes.dart';
import 'package:weatherapp/screens/weather_screen.dart';

void main() => runApp(
      MaterialApp(
        home: WeatherScreen(),
        routes: Routes.mainRoute,
      ),
    );
