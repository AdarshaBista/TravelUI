import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:travel_ui/ui/styles/index.dart';

import 'package:travel_ui/providers/place_provider.dart';
import 'package:travel_ui/providers/category_provider.dart';

import 'package:flutter_villains/villain.dart';
import 'package:travel_ui/ui/pages/bottom_nav_page.dart';

// For Flutter Desktop Support. To be removed later
import 'dart:io';
import 'package:flutter/foundation.dart' show debugDefaultTargetPlatformOverride;

void _setTargetPlatformForDesktop() {
  TargetPlatform targetPlatform;
  if (Platform.isMacOS) {
    targetPlatform = TargetPlatform.iOS;
  } else if (Platform.isLinux || Platform.isWindows) {
    targetPlatform = TargetPlatform.android;
  }
  if (targetPlatform != null) {
    debugDefaultTargetPlatformOverride = targetPlatform;
  }
}

void main() {
  _setTargetPlatformForDesktop();
  runApp(App());
}

class App extends StatelessWidget {
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<PlaceProvider>.value(
          value: PlaceProvider(),
        ),
        Provider<CategoryProvider>.value(
          value: CategoryProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Travel UI',
        theme: ThemeData(
          brightness: Brightness.light,
          fontFamily: 'JosefinSans',
          primaryColor: primaryColor,
          accentColor: accentColor,
          backgroundColor: backgroundColor,
          iconTheme: primaryIconTheme,
        ),
        navigatorObservers: [
          VillainTransitionObserver(),
        ],
        home: BottomNavPage(),
      ),
    );
  }
}
