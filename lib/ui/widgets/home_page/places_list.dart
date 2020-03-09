import 'package:flutter/material.dart';

import 'package:travel_ui/ui/styles/index.dart';
import 'package:travel_ui/models/place.dart';

import 'package:travel_ui/ui/transitions/villain_translate.dart';
import 'package:travel_ui/ui/widgets/home_page/image_card.dart';

class PlacesList extends StatelessWidget {
  final String title;
  final List<Place> places;
  final int index;

  PlacesList({
    @required this.title,
    @required this.places,
    @required this.index,
  })  : assert(title != null),
        assert(places != null),
        assert(index != null);

  @override
  Widget build(BuildContext context) {
    final double xOffset = index % 2 == 0 ? -0.5 : 0.5;
    return VillainTranslate(
      fromOffset: Offset(xOffset, 0.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        height: 200.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
              child: Text(
                title,
                style: largeTextStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 10.0),
                scrollDirection: Axis.horizontal,
                itemCount: places.length,
                itemBuilder: (BuildContext context, int index) => ImageCard(place: places[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
