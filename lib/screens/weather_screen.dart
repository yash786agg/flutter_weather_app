import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/datasource/remote/api_client.dart';
import 'package:weatherapp/domain/bloc/fetch_weather_coordinates.dart';
import 'package:weatherapp/domain/bloc/weather_bloc.dart';
import 'package:weatherapp/domain/model/Weather_data.dart';
import 'package:weatherapp/domain/repository/weather_repository.dart';
import 'package:weatherapp/services/location.dart';
import 'package:weatherapp/utils/change_city_dialog.dart';
import 'package:weatherapp/utils/constants.dart';
import 'package:weatherapp/utils/popup_menu_options.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/widgets/weather_widgets.dart';

class WeatherScreen extends StatefulWidget {
  final WeatherRepository weatherRepository = WeatherRepository(
      weatherApiClient: WeatherApiClient(
    apiKey: Constant.openWeatherMapApiKey,
    httpClient: http.Client(),
  ));

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>
    with WidgetsBindingObserver {
  WeatherBloc _weatherBloc;
  LocationServices locationServices = LocationServices();
  double latitude;
  double longitude;
  String _cityName;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    _weatherBloc = WeatherBloc(weatherRepository: widget.weatherRepository);
    print("AppLifecycleState initState");
    getLocation();
  }

  void getLocation() async {
    bool permissionStatus = await locationServices.getPermissionStatus();
    print('getLocation PermissionStatus: $permissionStatus');
    if (permissionStatus) {
      bool isGPSEnabled = await locationServices.isGpsServiceEnabled();
      print('getLocation isGPSEnabled: $isGPSEnabled');

      if (isGPSEnabled) {
        print('getLocation isGPSEnabled first: $isGPSEnabled');
        var locationData = await locationServices.getLocation();
        print('getLocation latitude: ${locationData.latitude}');
        print('getLocation latitude: ${locationData.longitude}');
        latitude = locationData.latitude;
        longitude = locationData.longitude;
        _cityName = null;
        _weatherBloc.dispatchCoordinates(FetchWeather(
            latitude: latitude, longitude: longitude, cityName: _cityName));
      } else {
        print('getLocation gpsDialogFlag seven');
        locationServices.openSettings(
            settingType: LocationServices.locationSettings);
      }
    } else
      locationServices.openSettings(settingType: LocationServices.appSettings);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('AppLifecycleState didChangeAppLifecycleState $state');
    if (state == AppLifecycleState.resumed) {
      print("Lifecycle didChangeAppLifecycleState state $state");
      getLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("build called");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
        ),
        centerTitle: false,
        textTheme: TextTheme(
          title: TextStyle(
            color: Color(0xFF414141),
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          PopUpMenuOptions(
            onSelected: (OptionsMenu result) {
              switch (result) {
                case OptionsMenu.changeCity:
                  print('PopUpMenuOptions Change City cliked!!');
                  changeCityDialog();
                  break;
                case OptionsMenu.settings:
                  print('PopUpMenuOptions settings cliked!!');
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SettingScreen();
                      },
                    ),
                  );*/
                  break;
              }
            },
          ),
        ],
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 40.0),
            child: StreamBuilder(
              stream: _weatherBloc.weatherData,
              // ignore: missing_return
              builder: (context, AsyncSnapshot<WeatherData> snapshot) {
                if (snapshot.hasData) {
                  //_progressDialog.hide();
                  return WeatherWidget(weatherData: snapshot.data);
                } else if (snapshot.hasError) {
                  print(
                      'Error while fecthing weather data: ${snapshot.error.toString()}');
                  //_progressDialog.hide();
                } else {
                  return Center(
                      child:
                          CircularProgressIndicator()); //return EmptyWidget();
                }
              },
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black38,
    );
  }

  @override
  void dispose() {
    print("AppLifecycleState dispose");
    _weatherBloc.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void changeCityDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return ChangeCityDialog(
            onOkPressed: (text) {
              if (text != null) {
                _cityName = text;
                _weatherBloc.dispatchCoordinates(FetchWeather(
                    latitude: 0.0, longitude: 0.0, cityName: _cityName));
              }
            },
          );
        });
  }
}
