import 'package:flutter/material.dart';

import 'package:smooth_star_rating/smooth_star_rating.dart';

class Rating extends StatelessWidget {
  final double rating;
  final Color color;
  final double size;
  final Function(double) onChanged;
  final int starCount;

  Rating({
    @required this.rating,
    @required this.onChanged,
    this.color = Colors.white,
    this.size = 20.0,
    this.starCount = 5,
  }) : assert(rating != null);

  @override
  Widget build(BuildContext context) {
    return SmoothStarRating(
      rating: rating,
      starCount: starCount,
      size: size,
      allowHalfRating: true,
      spacing: 0.0,
      color: color,
      borderColor: color,
      onRatingChanged: onChanged,
    );
  }
}
