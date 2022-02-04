part of '../../bloc/geolocation/geolocation_bloc.dart';

abstract class GeolocationEvent extends Equatable {
  const GeolocationEvent();

  @override
  List<Object> get props => [];
}

//Our events
class LoadGeoLocation extends GeolocationEvent {}

//Update event that will update the position
class UpdateGeoLoaction extends GeolocationEvent {
  final Position position;

  const UpdateGeoLoaction({required this.position});

  @override
  List<Object> get props => [position];
}
