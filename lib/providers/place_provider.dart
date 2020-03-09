import 'package:travel_ui/data/data.dart';

import 'package:travel_ui/models/place.dart';

class PlaceProvider {
  List<Place> _places = dummyPlaces;
  List<Place> get places => _places;

  Place getById(int id) => _places.firstWhere((place) => place.id == id);

  List<Place> getByTitle(String title) =>
      _places.where((place) => place.title.toLowerCase().contains(title.toLowerCase())).toList();

  List<Place> getByRating(double rating) => _places.where((place) => place.rating >= rating).toList();

  List<Place> getByDistance(double distance) => _places.where((place) => place.distance <= distance).toList();

  List<Place> getByCategory(String category) => _places.where((place) => place.category == category).toList();

  List<Place> getTopRated() => getByRating(4.0);

  List<Place> getNearby() => getByDistance(500.0);
}
