class PlaceAutoComplete {
  final String description;
  final String placeId;

  PlaceAutoComplete({required this.description, required this.placeId});

  factory PlaceAutoComplete.fromJson(Map<String, dynamic> json) {
    return PlaceAutoComplete(
        description: json["description"], placeId: json["place_id"]);
  }
}
