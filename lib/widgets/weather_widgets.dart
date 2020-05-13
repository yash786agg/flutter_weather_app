import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/domain/model/Weather_data.dart';
import 'package:weatherapp/widgets/weather_value.dart';

class WeatherWidget extends StatelessWidget {
  WeatherWidget({@required this.weatherData}) : assert(weatherData != null);

  final WeatherData weatherData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            this.weatherData.name.toUpperCase(),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            this.weatherData.tempDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF414141),
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Icon(
            this.weatherData.getIconData(this.weatherData.tempIcon),
            color: Colors.white,
            size: 70.0,
          ),
          SizedBox(
            height: 40.0,
          ),
          Text(
            '${this.weatherData.temp.toInt()}°C',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 72.0,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WeatherValue(
                weatherText: 'max',
                weatherTextValue: '${this.weatherData.tempMax}°C',
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  width: 1.0,
                  height: 35.0,
                  color: Color(0xFF414141),
                ),
              ),
              WeatherValue(
                weatherText: 'min',
                weatherTextValue: '${this.weatherData.tempMin}°C',
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                WeatherValue(
                  weatherText: 'max',
                  weatherIcon: IconData(0xf00d, fontFamily: 'WeatherIcons'),
                  weatherTextValue: '14°C',
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                ),
                WeatherValue(
                  weatherText: 'max',
                  weatherIcon: IconData(0xf00d, fontFamily: 'WeatherIcons'),
                  weatherTextValue: '14°C',
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                ),
                WeatherValue(
                  weatherText: 'max',
                  weatherIcon: IconData(0xf00d, fontFamily: 'WeatherIcons'),
                  weatherTextValue: '14°C',
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                ),
                WeatherValue(
                  weatherText: 'max',
                  weatherIcon: IconData(0xf00d, fontFamily: 'WeatherIcons'),
                  weatherTextValue: '14°C',
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                ),
                WeatherValue(
                  weatherText: 'max',
                  weatherIcon: IconData(0xf00d, fontFamily: 'WeatherIcons'),
                  weatherTextValue: '14°C',
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                ),
                WeatherValue(
                  weatherText: 'max',
                  weatherIcon: IconData(0xf00d, fontFamily: 'WeatherIcons'),
                  weatherTextValue: '14°C',
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                ),
                WeatherValue(
                  weatherText: 'max',
                  weatherIcon: IconData(0xf00d, fontFamily: 'WeatherIcons'),
                  weatherTextValue: '14°C',
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                ),
                WeatherValue(
                  weatherText: 'max',
                  weatherIcon: IconData(0xf00d, fontFamily: 'WeatherIcons'),
                  weatherTextValue: '14°C',
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                ),
                WeatherValue(
                  weatherText: 'max',
                  weatherIcon: IconData(0xf00d, fontFamily: 'WeatherIcons'),
                  weatherTextValue: '14°C',
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WeatherValue(
                weatherText: 'Wind speed',
                weatherIcon: null,
                weatherTextValue: '${this.weatherData.windSpeed} ms/c',
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  width: 1.0,
                  height: 35.0,
                  color: Color(0xFF414141),
                ),
              ),
              WeatherValue(
                weatherText: 'Sunrise',
                weatherIcon: null,
                weatherTextValue: DateFormat('h:mm a')
                    .format(DateTime.fromMillisecondsSinceEpoch(
                        this.weatherData.sunrise * 1000))
                    .toString(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  width: 1.0,
                  height: 35.0,
                  color: Color(0xFF414141),
                ),
              ),
              WeatherValue(
                weatherText: 'Sunset',
                weatherIcon: null,
                weatherTextValue: DateFormat('h:mm a')
                    .format(DateTime.fromMillisecondsSinceEpoch(
                        this.weatherData.sunset * 1000))
                    .toString(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Container(
                  width: 1.0,
                  height: 35.0,
                  color: Color(0xFF414141),
                ),
              ),
              WeatherValue(
                weatherText: 'Humidity',
                weatherIcon: null,
                weatherTextValue: '${this.weatherData.humidity.toString()} %',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
