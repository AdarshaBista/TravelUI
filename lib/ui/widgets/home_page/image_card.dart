import 'package:flutter/material.dart';

import 'package:travel_ui/ui/styles/index.dart';
import 'package:travel_ui/models/place.dart';

import 'package:travel_ui/ui/transitions/villain_scale.dart';
import 'package:travel_ui/ui/widgets/common/custom_card.dart';
import 'package:travel_ui/ui/widgets/common/gradient_container.dart';

import 'package:travel_ui/ui/pages/place_details_page.dart';

class ImageCard extends StatelessWidget {
  final Place place;

  ImageCard({
    @required this.place,
  }) : assert(place != null);

  @override
  Widget build(BuildContext context) {
    return VillainScale(
      child: AspectRatio(
        aspectRatio: 1,
        child: CustomCard(
          margin: EdgeInsets.all(6.0),
          borderRadius: 8.0,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => PlaceDetailsPage(place: place),
                ),
              );
            },
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: <Widget>[
                _buildbackground(),
                _buildTitle(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildbackground() => GradientContainer(
        gradientColors: [
          Colors.transparent,
          darkGradientColor,
        ],
        child: Image.asset(
          place.imageUrl,
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          fit: BoxFit.cover,
        ),
      );

  Widget _buildTitle() => Padding(
        padding: EdgeInsets.all(10.0),
        child: Text(
          place.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: smallTextStyle.copyWith(color: Colors.white),
        ),
      );
}
