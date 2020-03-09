import 'package:flutter/material.dart';

import 'package:travel_ui/ui/styles/index.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    String title = '',
    double elevation = 8.0,
    IconThemeData iconTheme = primaryIconTheme,
    List<Widget> actions,
  }) : super(
          backgroundColor: backgroundColor,
          elevation: elevation,
          centerTitle: true,
          iconTheme: iconTheme,
          actions: actions,
          title: Text(
            title,
            style: largeTextStyle,
          ),
        );
}
