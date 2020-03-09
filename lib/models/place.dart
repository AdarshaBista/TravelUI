import 'package:flutter/material.dart';

class Place {
  final int id;
  final String title;
  final String imageUrl;
  final String description;
  final double distance;
  final double rating;
  final double lat;
  final double lng;
  final String category;

  Place({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.description,
    @required this.lat,
    @required this.lng,
    @required this.distance,
    @required this.rating,
    @required this.category,
  })  : assert(id != null),
        assert(title != null),
        assert(imageUrl != null),
        assert(description != null),
        assert(lat != null),
        assert(lng != null),
        assert(distance != null),
        assert(rating != null),
        assert(category != null);
}
