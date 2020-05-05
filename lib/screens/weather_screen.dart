import 'package:flutter/material.dart';
import 'package:weatherapp/services/location.dart';
import 'package:weatherapp/utils/popup_menu_options.dart';
import 'package:weatherapp/utils/progress_dialog.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>
    with WidgetsBindingObserver {
  LocationServices locationServices = LocationServices();
  double latitude;
  double longitude;

  AppLifecycleState _lifecycleState;
  ProgressDialog _progressDialog;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
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
        title: Text('Weather App'),
        centerTitle: false,
        textTheme: TextTheme(
          title: TextStyle(
            color: Color(0xFF414141),
            fontSize: 17.0,
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
        backgroundColor: Colors.black38,
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'MOUNTAIN VIEW',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black38,
    );
  }

  @override
  void dispose() {
    print("AppLifecycleState dispose");
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}