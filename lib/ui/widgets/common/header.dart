import 'package:flutter/material.dart';

import 'package:travel_ui/ui/styles/index.dart';

import 'package:travel_ui/ui/transitions/villain_translate.dart';

class Header extends StatelessWidget {
  final String title;
  final String boldTitle;

  Header({
    this.title,
    this.boldTitle,
  });

  @override
  Widget build(BuildContext context) {
    return VillainTranslate(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16.0),
              child: Text(
                title,
                style: veryLargeTextStyle,
              ),
            ),
          if (boldTitle != null)
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                boldTitle,
                style: veryLargeBoldTextStyle.copyWith(fontSize: 32.0),
              ),
            ),
        ],
      ),
    );
  }
}
