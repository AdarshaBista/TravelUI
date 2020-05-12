import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:travel_ui/ui/styles/index.dart';
import 'package:device_preview/device_preview.dart';

import 'package:travel_ui/providers/place_provider.dart';
import 'package:travel_ui/providers/category_provider.dart';

import 'package:flutter_villains/villain.dart';
import 'package:travel_ui/ui/pages/bottom_nav_page.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: Platform.isWindows,
      usePreferences: false,
      isToolBarVisible: true,
      areSettingsEnabled: true,
      style: DevicePreviewStyle(
        background: BoxDecoration(color: Color(0xFF24292E)),
        toolBar: DevicePreviewToolBarStyle.dark().copyWith(
          position: DevicePreviewToolBarPosition.left,
        ),
      ),
      data: DevicePreviewData(
        deviceIndex: 3,
        isFrameVisible: true,
      ),
      builder: (_) => (App()),
    ),
  );
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
        builder: DevicePreview.appBuilder,
        locale: DevicePreview.of(context).locale,
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
