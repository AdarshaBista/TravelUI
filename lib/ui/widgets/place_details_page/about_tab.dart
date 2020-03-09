import 'package:flutter/material.dart';

import 'package:travel_ui/ui/styles/index.dart';
import 'package:travel_ui/models/place.dart';

import 'package:travel_ui/ui/widgets/common/rating.dart';

class AboutTab extends StatelessWidget {
  final Place place;

  AboutTab({
    @required this.place,
  }) : assert(place != null);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shrinkWrap: true,
      children: <Widget>[
        _buildDetails(),
        SizedBox(height: 32.0),
        _buildDescription(),
      ],
    );
  }

  Widget _buildDetails() => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 8.0),
          Rating(
            rating: place.rating,
            color: place.rating > 3 ? Colors.greenAccent : Colors.redAccent,
            onChanged: (double newRating) {},
          ),
          SizedBox(height: 8.0),
          Text(
            "${place.distance} metres away",
            style: smallTextStyle,
          ),
        ],
      );

  Widget _buildDescription() => Text(
        place.description,
        textAlign: TextAlign.justify,
        style: mediumTextStyle.copyWith(color: Colors.black.withOpacity(0.8)),
      );
}
