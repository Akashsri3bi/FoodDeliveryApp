part of '../../bloc/geolocation/geolocation_bloc.dart';

abstract class GeolocationState extends Equatable {
  const GeolocationState();

  @override
  List<Object> get props => [];
}

class GeolocationLoading extends GeolocationState {}

class GeolocationLoaded extends GeolocationState {
  //Final state when the final location of user is calculated ;
  final Position position;

  const GeolocationLoaded({required this.position});

  @override
  List<Object> get props => [position];
}

class GeolocationError extends GeolocationState {}
