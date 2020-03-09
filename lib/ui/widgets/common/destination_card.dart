import 'dart:math';

import 'package:flutter/material.dart';

import 'package:travel_ui/ui/styles/index.dart';
import 'package:travel_ui/models/category.dart';

import 'package:travel_ui/ui/transitions/villain_translate.dart';
import 'package:travel_ui/ui/widgets/common/rating.dart';
import 'package:travel_ui/ui/widgets/common/custom_card.dart';
import 'package:travel_ui/ui/widgets/common/gradient_container.dart';

import 'package:travel_ui/ui/pages/discover_page.dart';

class DestinationCard extends StatelessWidget {
  final Category category;
  final int index;
  final Random _rng = Random();

  DestinationCard({
    @required this.category,
    @required this.index,
  })  : assert(category != null),
        assert(index != null);

  @override
  Widget build(BuildContext context) {
    final double xOffset = index % 2 == 0 ? -0.5 : 0.5;
    return VillainTranslate(
      fromOffset: Offset(xOffset, 0.0),
      child: AspectRatio(
        aspectRatio: 10 / 14,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) => DiscoverPage(category: category),
              ),
            );
          },
          child: CustomCard(
            borderRadius: 12.0,
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: <Widget>[
                _buildBackground(),
                _buildDetails(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackground() => GradientContainer(
        gradientColors: [
          Colors.transparent,
          darkGradientColor,
        ],
        child: Image.asset(
          category.places[_rng.nextInt(category.places.length)].imageUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );

  Widget _buildDetails() => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              category.title,
              style: largeTextStyle.copyWith(color: Colors.white),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8.0),
            Text(
              "${category.places.length} places",
              style: smallTextStyle.copyWith(color: Colors.white70),
            ),
            SizedBox(height: 8.0),
            Rating(
              rating: category.rating,
              color: Colors.white60,
              onChanged: (double newRating) {},
            ),
          ],
        ),
      );
}
