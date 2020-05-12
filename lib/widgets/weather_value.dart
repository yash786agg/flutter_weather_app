import 'package:flutter/material.dart';
import 'package:weatherapp/widgets/empty_widget.dart';

class WeatherValue extends StatelessWidget {
  WeatherValue({
    this.weatherText,
    this.weatherIcon,
    this.weatherTextValue,
  });

  final String weatherText;
  final IconData weatherIcon;
  final String weatherTextValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          weatherText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF414141),
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        this.weatherIcon != null
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Icon(
                  weatherIcon,
                  color: Color(0xFFD3D3D3),
                  size: 19.0,
                ),
              )
            : EmptyWidget(),
        SizedBox(
          height: 10.0,
        ),
        Text(
          weatherTextValue,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF414141),
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
