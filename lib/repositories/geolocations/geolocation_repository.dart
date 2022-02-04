import 'package:food/repositories/geolocations/base_geolocation_repository.dart';
import 'package:geolocator/geolocator.dart';

class GeoLocationRepository extends BaseGeolocationRepository {
  GeoLocationRepository();

  @override
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
