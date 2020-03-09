import 'package:flutter/material.dart';

class GradientContainer extends Container {
  GradientContainer({
    List<double> gradientStops,
    List<Color> gradientColors,
    AlignmentGeometry gradientBegin = Alignment.topCenter,
    AlignmentGeometry gradientEnd = Alignment.bottomCenter,
    double width,
    double height,
    EdgeInsetsGeometry margin = const EdgeInsets.all(0.0),
    EdgeInsetsGeometry padding = const EdgeInsets.all(0.0),
    AlignmentGeometry alignment = Alignment.bottomLeft,
    Widget child,
  }) : super(
          width: width,
          height: height,
          margin: margin,
          padding: padding,
          alignment: alignment,
          foregroundDecoration: BoxDecoration(
            backgroundBlendMode: BlendMode.srcOver,
            gradient: LinearGradient(
              begin: gradientBegin,
              end: gradientEnd,
              stops: gradientStops,
              colors: gradientColors,
            ),
          ),
          child: child,
        );
}
