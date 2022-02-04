import 'dart:convert';

import 'package:food/models/place_model.dart';
import 'package:food/models/places_autocomplete_model.dart';
import 'package:food/repositories/places/base_places_repository.dart';
import 'package:http/http.dart' as http;

class PlacesRepository extends BasePlacesRepository {
  final String key = "AIzaSyDwFm_l5hRNuMb6BtvI9e6NMcg6b_sFJAk";
  final String types = "geocode";

  @override
  Future<List<PlaceAutoComplete>> getAutoComplete(String searchInput) async {
    final String url =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchInput&types=$types&key=$key";
    var response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    var results = json["predictions"] as List;

    return results.map((place) => PlaceAutoComplete.fromJson(place)).toList();
  }

  @override
  Future<Place> getPlace(String placeId) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key';
    var response = await http.get(Uri.parse(url));
    var json = jsonDecode(response.body);
    var results = json['results'] as Map<String, dynamic>;
    return Place.fromJson(results);
  }
}
