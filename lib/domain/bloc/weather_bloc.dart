import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:weatherapp/domain/model/Weather_data.dart';
import 'package:weatherapp/domain/repository/weather_repository.dart';
import 'package:weatherapp/domain/bloc/fetch_weather_coordinates.dart';

class WeatherBloc {
  WeatherBloc({
    @required this.weatherRepository,
  }) : assert(weatherRepository != null);

  FetchWeather _fetchWeather;
  final WeatherRepository weatherRepository;

  final _weatherDataFetcher = PublishSubject<WeatherData>();

  Stream<WeatherData> get weatherData => _weatherDataFetcher.stream;

  void _fetchWeatherData() async {
    WeatherData weatherData = await weatherRepository.getWeatherData(
        latitude: _fetchWeather.latitude, longitude: _fetchWeather.longitude);

    _weatherDataFetcher.sink.add(weatherData);
  }

  void dispatchCoordinates(FetchWeather fetchWeather) {
    _fetchWeather = fetchWeather;
    _fetchWeatherData();
  }

  void dispose() {
    _weatherDataFetcher.close();
  }
}
