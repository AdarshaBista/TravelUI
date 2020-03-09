import 'package:flutter/material.dart';
import 'package:flutter_villains/villain.dart';

class VillainScale extends Villain {
  VillainScale({
    @required child,
    int fromInMilliseconds = 0,
    int toInMilliseconds = 500,
    double fromScale = 0.5,
    double toScale = 1.0,
  })  : assert(child != null),
        super(
          child: child,
          animateEntrance: true,
          animateExit: true,
          animateReEntrance: true,
          villainAnimation: VillainAnimation.scale(
            curve: Curves.easeOutExpo,
            from: Duration(milliseconds: fromInMilliseconds),
            to: Duration(milliseconds: toInMilliseconds),
            fromScale: fromScale,
            toScale: toScale,
          ),
        );
}
