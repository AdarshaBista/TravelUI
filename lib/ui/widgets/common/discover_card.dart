import 'package:flutter/material.dart';

import 'package:travel_ui/ui/styles/index.dart';
import 'package:travel_ui/models/place.dart';

import 'package:travel_ui/ui/transitions/villain_translate.dart';
import 'package:travel_ui/ui/widgets/common/rating.dart';
import 'package:travel_ui/ui/widgets/common/custom_card.dart';
import 'package:travel_ui/ui/widgets/common/gradient_container.dart';

import 'package:travel_ui/ui/pages/place_details_page.dart';

class DiscoverCard extends StatelessWidget {
  final Place place;
  final int index;

  DiscoverCard({
    @required this.place,
    @required this.index,
  })  : assert(place != null),
        assert(index != null);

  @override
  Widget build(BuildContext context) {
    final double xOffset = index % 2 == 0 ? -0.5 : 0.5;
    return VillainTranslate(
      fromOffset: Offset(xOffset, 0.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => PlaceDetailsPage(place: place),
            ),
          );
        },
        child: CustomCard(
          margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          borderRadius: 8.0,
          child: Container(
            height: 130.0,
            child: Stack(
              alignment: Alignment.bottomLeft,
              overflow: Overflow.clip,
              children: <Widget>[
                _buildbackground(),
                _buildDetails(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildbackground() => Hero(
        tag: place.id,
        child: GradientContainer(
          gradientColors: [
            darkGradientColor,
            Colors.transparent,
          ],
          gradientBegin: Alignment.bottomLeft,
          gradientEnd: Alignment.topRight,
          child: Image.asset(
            place.imageUrl,
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.3),
            colorBlendMode: BlendMode.multiply,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      );

  Widget _buildDetails(BuildContext context) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Rating(
              rating: place.rating,
              color: place.rating > 3 ? Colors.greenAccent : Colors.redAccent,
              onChanged: (double newRating) {},
            ),
            SizedBox(height: 8.0),
            Text(
              "${place.distance} metres away",
              style: smallTextStyle.copyWith(color: Colors.white70),
            ),
            SizedBox(height: 8.0),
            Text(
              place.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: mediumTextStyle.copyWith(color: Colors.white),
            ),
          ],
        ),
      );
}
