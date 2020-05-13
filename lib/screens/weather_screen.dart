import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/datasource/remote/api_client.dart';
import 'package:weatherapp/domain/bloc/fetch_weather_coordinates.dart';
import 'package:weatherapp/domain/bloc/weather_bloc.dart';
import 'package:weatherapp/domain/model/Weather_data.dart';
import 'package:weatherapp/domain/repository/weather_repository.dart';
import 'package:weatherapp/services/location.dart';
import 'package:weatherapp/utils/constants.dart';
import 'package:weatherapp/utils/popup_menu_options.dart';
import 'package:weatherapp/utils/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/widgets/empty_widget.dart';
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

  AppLifecycleState _lifecycleState;
  ProgressDialog _progressDialog;

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
    print('PermissionStatus: $permissionStatus');
    if (permissionStatus) {
      bool isGPSOpen = await locationServices.checkGPSAvailable();
      print('getLocation isGPSOpen: $isGPSOpen');
      if (isGPSOpen) {
        await _progressDialog.show();
        var locationData = await locationServices.getLocation();
        print('getLocation latitude: ${locationData.latitude}');
        print('getLocation latitude: ${locationData.longitude}');
        latitude = locationData.latitude;
        longitude = locationData.longitude;
        _weatherBloc.dispatchCoordinates(
            FetchWeather(latitude: latitude, longitude: longitude));
        await _progressDialog.hide();
      } else
        locationServices.openSettings(
            settingType: LocationServices.locationSettings);
    } else
      locationServices.openSettings(settingType: LocationServices.appSettings);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() {
      _lifecycleState = state;
      print('AppLifecycleState $state');
    });
  }

  /*@override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // user returned to our app
      print('AppLifecycleState resumed');
      getLocation();
    } else if (state == AppLifecycleState.inactive) {
      // app is inactive
      print('AppLifecycleState inactive');
    } else if (state == AppLifecycleState.paused) {
      // user is about quit our app temporally
      print('AppLifecycleState paused');
    } else if (state == AppLifecycleState.detached) {
      print('AppLifecycleState detached');
    }
  }*/

  @override
  Widget build(BuildContext context) {
    _progressDialog = new ProgressDialog(context);
    _progressDialog = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
      showLogs: true,
    );

    if (_lifecycleState == AppLifecycleState.resumed) {
      print("Lifecycle state $_lifecycleState");
      getLocation();
    }
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
                  break;
                case OptionsMenu.settings:
                  print('PopUpMenuOptions settings cliked!!');
                  break;
              }
            },
          ),
        ],
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
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
                  return EmptyWidget();
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
}
