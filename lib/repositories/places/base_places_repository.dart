import 'package:food/models/place_model.dart';
import 'package:food/models/places_autocomplete_model.dart';

abstract class BasePlacesRepository {
  Future<List<PlaceAutoComplete>?> getAutoComplete(String searchInput) async {}
}

Future<Place?> getPlace(String placeId) async {}
