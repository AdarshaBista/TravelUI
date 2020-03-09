import 'package:flutter/material.dart';

import 'package:travel_ui/models/place.dart';

import 'package:travel_ui/ui/widgets/place_details_page/placecard_tile.dart';

class PlaceCardsTab extends StatelessWidget {
  final Place place;

  PlaceCardsTab({
    @required this.place,
  }) : assert(place != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) => PlaceCardTile(),
      ),
    );
  }
}
