import 'package:flutter/material.dart';

import 'package:travel_ui/models/place.dart';

class Category {
  final int id;
  final String title;
  final double rating;
  final List<Place> places;

  Category({
    @required this.id,
    @required this.title,
    @required this.places,
    @required this.rating,
  })  : assert(id != null),
        assert(title != null),
        assert(places != null),
        assert(rating != null);
}
