import 'package:flutter/services.dart';
import 'package:location/location.dart';

class LocationServices {
  PermissionStatus _permissionGranted;
  //bool _serviceEnabled;
  Location location = new Location();
  static const appSettings = 'app_settings';
  static const locationSettings = 'location';
  static const platform = const MethodChannel('app_settings');

  void openSettings({String settingType}) async {
    print('openSettings');

    await platform.invokeMethod(settingType);
  }

  Future<LocationData> getLocation() async {
    print('getLocation');
    LocationData data = await location.getLocation();
    return data;
  }

  Future<bool> getPermissionStatus() async {
    bool permissionStatus = false;

    _permissionGranted = await location.hasPermission();
    print('PermissionGranted outside: $_permissionGranted');
    if (_permissionGranted == PermissionStatus.granted) {
      print('PermissionGranted if: $_permissionGranted');
      permissionStatus = true;
    } else if (_permissionGranted == PermissionStatus.denied ||
        _permissionGranted == PermissionStatus.deniedForever) {
      _permissionGranted = await location.requestPermission();
      print('PermissionGranted else if: $_permissionGranted');
      if (_permissionGranted == PermissionStatus.granted) {
        print('PermissionGranted else if if: $_permissionGranted');
        permissionStatus = true;
      } else {
        print('PermissionGranted else if else: $_permissionGranted');
        permissionStatus = false;
      }
    }

    return permissionStatus;
  }

  Future<bool> isGpsServiceEnabled() async {
    return await location.serviceEnabled();
  }

  /* Future<bool> requestGpsService() async {
    return await location.requestService();
  }*/

  /*Future<bool> checkGPSAvailable() async {
    bool isGPSOpen = false;
    _serviceEnabled = await location.serviceEnabled();
    print('checkGPSAvailable _serviceEnabled: $_serviceEnabled');
    if (!_serviceEnabled) {
      isGPSOpen = false;
      _serviceEnabled = await location.requestService();
      print('checkGPSAvailable _serviceEnabled if: $_serviceEnabled');
      if (!_serviceEnabled) {
        print('checkGPSAvailable _serviceEnabled if if: $_serviceEnabled');
        isGPSOpen = false;
      } else
        isGPSOpen = true;
    } else
      isGPSOpen = true;

    return isGPSOpen;
  }*/
}
