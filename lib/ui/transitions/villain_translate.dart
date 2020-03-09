import 'package:flutter/material.dart';
import 'package:flutter_villains/villain.dart';

class VillainTranslate extends Villain {
  VillainTranslate({
    @required child,
    int fromInMilliseconds = 0,
    int toInMilliseconds = 500,
    Offset fromOffset = const Offset(0.0, -2.0),
    Offset toOffset = const Offset(0.0, 0.0),
  })  : assert(child != null),
        super(
          child: child,
          animateEntrance: true,
          animateExit: true,
          animateReEntrance: true,
          villainAnimation: VillainAnimation.translate(
            curve: Curves.easeOutExpo,
            from: Duration(milliseconds: fromInMilliseconds),
            to: Duration(milliseconds: toInMilliseconds),
            fromOffset: fromOffset,
            toOffset: toOffset,
          ),
        );
}
