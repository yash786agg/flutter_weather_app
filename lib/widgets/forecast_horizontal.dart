import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/widgets/weather_value.dart';
import 'package:weatherapp/domain/model/Weather_data.dart';

class ForecastHorizontal extends StatelessWidget {
  /*ForecastHorizontal({@required this.forecastData})
      : assert(forecastData != null);*/
  const ForecastHorizontal({
    Key key,
    @required this.forecastData,
  }) : super(key: key);

  final List<WeatherData> forecastData;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final items = this.forecastData[index];
            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Center(
                child: WeatherValue(
                  weatherText: DateFormat('E, ha').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          items.datetime * 1000)),
                  weatherIcon: items.getIconData(items.tempIcon),
                  weatherTextValue: '${items.temp.toInt()}°C',
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(
                height: 100,
                color: Colors.white,
              ),
          padding: EdgeInsets.only(left: 10, right: 10),
          itemCount: this.forecastData.length),
    );
  }
}
