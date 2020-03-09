import 'package:flutter/material.dart';

import 'package:travel_ui/ui/styles/index.dart';

class PlaceCardTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        "Title",
        style: smallTextStyle,
      ),
      leading: CircleAvatar(
        backgroundImage: AssetImage("assets/images/PrimeCollege.jpg"),
      ),
      children: <Widget>[
        Container(
          height: 100,
          color: Colors.transparent,
          child: Center(
            child: Text(
              'Coming Soon...',
              style: smallTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
