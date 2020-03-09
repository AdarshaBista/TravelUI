import 'package:flutter/material.dart';

import 'package:travel_ui/ui/styles/index.dart';
import 'package:travel_ui/models/place.dart';

import 'package:travel_ui/ui/transitions/villain_scale.dart';
import 'package:travel_ui/ui/transitions/villain_translate.dart';
import 'package:travel_ui/ui/widgets/common/rating.dart';
import 'package:travel_ui/ui/widgets/common/custom_card.dart';

import 'package:travel_ui/ui/pages/place_details_page.dart';

class PlaceCard extends StatelessWidget {
  final Place place;

  PlaceCard({
    @required this.place,
  }) : assert(place != null);

  @override
  Widget build(BuildContext context) {
    return VillainTranslate(
      fromOffset: Offset(0.0, 2.0),
      child: VillainScale(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => PlaceDetailsPage(place: place),
              ),
            );
          },
          child: Container(
            height: 140.0,
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _buildImage(),
                SizedBox(width: 16.0),
                _buildDetails(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage() => Hero(
        tag: place.id,
        child: Container(
          height: 110.0,
          width: 110.0,
          child: CustomCard(
            borderRadius: 8.0,
            child: Image.asset(
              place.imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
      );

  Widget _buildDetails(BuildContext context) => Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              place.title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: mediumTextStyle,
            ),
            SizedBox(height: 8.0),
            Rating(
              rating: place.rating,
              color: place.rating > 3 ? Colors.greenAccent : Colors.redAccent,
              onChanged: (double newRating) {},
            ),
            SizedBox(height: 8.0),
            Text(
              "${place.distance.toInt()} metres away",
              style: smallTextStyle,
            ),
          ],
        ),
      );
}
