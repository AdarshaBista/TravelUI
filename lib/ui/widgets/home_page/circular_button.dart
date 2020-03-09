import 'package:flutter/material.dart';

import 'package:travel_ui/ui/styles/index.dart';

import 'package:travel_ui/ui/transitions/villain_scale.dart';

class CircularButton extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Color backgroundColor;
  final Function onPressed;

  CircularButton({
    @required this.title,
    @required this.iconData,
    @required this.onPressed,
    this.backgroundColor = Colors.black,
  })  : assert(title != null),
        assert(iconData != null);

  @override
  Widget build(BuildContext context) {
    return VillainScale(
      child: GestureDetector(
        onTap: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: backgroundColor,
              child: Icon(
                iconData,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 2.0),
              width: MediaQuery.of(context).size.width / 5.0,
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: verySmallTextStyle.copyWith(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
