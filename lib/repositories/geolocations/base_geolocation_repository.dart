import 'package:geolocator/geolocator.dart';

abstract class BaseGeolocationRepository {
  //Here we have defined one function future which will return us currentLocation in a Position object .
  Future<Position?> getCurrentLocation() async {}
}
