import 'package:flutter/material.dart';

class CustomCard extends Card {
  CustomCard({
    Widget child,
    double borderRadius = 0.0,
    double elevation = 8.0,
    EdgeInsetsGeometry margin = const EdgeInsets.all(0.0),
  }) : super(
          elevation: elevation,
          clipBehavior: Clip.antiAlias,
          margin: margin,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: child,
        );
}
