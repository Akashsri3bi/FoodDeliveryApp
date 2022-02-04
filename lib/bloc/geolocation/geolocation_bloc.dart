import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food/repositories/geolocations/geolocation_repository.dart';
import 'package:geolocator/geolocator.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  final GeoLocationRepository _geoLocationRepository;
  StreamSubscription? _geoLocationSubscription;

  GeolocationBloc({required GeoLocationRepository geoLocationRepository})
      : _geoLocationRepository = geoLocationRepository,
        super(GeolocationLoading());

  @override
  Stream<GeolocationState> mapEventToState(GeolocationEvent event) async* {
    if (event is LoadGeoLocation) {
      yield* _mapLoadGeolocationToState();
    } else if (event is UpdateGeoLoaction) {
      yield* _mapUpdateGeolocationToState(event);
    }
  }

  //This is used for Event Handling
  Stream<GeolocationState> _mapLoadGeolocationToState() async* {
    _geoLocationSubscription?.cancel();
    final Position position = await _geoLocationRepository.getCurrentLocation();
    add(UpdateGeoLoaction(position: position));
  }

  Stream<GeolocationState> _mapUpdateGeolocationToState(
      UpdateGeoLoaction event) async* {
    yield GeolocationLoaded(position: event.position);
  }

  @override
  Future<void> close() {
    _geoLocationSubscription?.cancel();
    return super.close();
  }
}
