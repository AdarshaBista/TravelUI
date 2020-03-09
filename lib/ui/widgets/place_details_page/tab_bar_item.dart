import 'package:flutter/material.dart';

import 'package:travel_ui/ui/transitions/villain_scale.dart';

class TabBarItem extends StatelessWidget {
  final String title;

  TabBarItem({
    @required this.title,
  }) : assert(title != null);

  @override
  Widget build(BuildContext context) {
    return VillainScale(
      child: Tab(text: title),
    );
  }
}
