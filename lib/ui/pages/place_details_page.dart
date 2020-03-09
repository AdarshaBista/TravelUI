import 'package:flutter/material.dart';

import 'package:latlong/latlong.dart';
import 'package:travel_ui/models/place.dart';
import 'package:travel_ui/ui/styles/index.dart';

import 'package:travel_ui/ui/transitions/villain_translate.dart';
import 'package:travel_ui/ui/widgets/common/gradient_container.dart';
import 'package:travel_ui/ui/widgets/place_details_page/about_tab.dart';
import 'package:travel_ui/ui/widgets/place_details_page/tab_bar_item.dart';
import 'package:travel_ui/ui/widgets/place_details_page/placecards_tab.dart';

import 'package:travel_ui/ui/pages/map_page.dart';

class PlaceDetailsPage extends StatelessWidget {
  final Place place;

  PlaceDetailsPage({
    @required this.place,
  }) : assert(place != null);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: backgroundColor,
        bottomNavigationBar: _buildTabBar(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.map),
          backgroundColor: primaryColor,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 64.0),
                  clipBehavior: Clip.antiAlias,
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: MapPage(
                    center: LatLng(place.lat, place.lng),
                  ),
                );
              },
            );
          },
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, value) {
            return [
              _buildAppBar(),
            ];
          },
          body: _buildTabBarView(),
        ),
      ),
    );
  }

  TabBar _buildTabBar() => TabBar(
        isScrollable: false,
        unselectedLabelColor: Colors.black54,
        labelColor: primaryColor,
        labelStyle: smallTextStyle.copyWith(fontWeight: FontWeight.w700),
        indicatorColor: primaryColor,
        indicatorPadding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 4.0),
        tabs: [
          TabBarItem(title: "ABOUT"),
          TabBarItem(title: "PLACE CARDS"),
        ],
      );

  SliverAppBar _buildAppBar() => SliverAppBar(
        backgroundColor: Colors.black,
        iconTheme: primaryIconTheme.copyWith(color: Colors.white),
        floating: false,
        pinned: true,
        elevation: 8.0,
        expandedHeight: 220.0,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: VillainTranslate(
            child: Text(
              place.title,
              style: mediumTextStyle.copyWith(color: Colors.white),
            ),
          ),
          background: _buildAppBarBackground(),
        ),
      );

  Widget _buildAppBarBackground() => Hero(
        tag: place.id,
        child: GradientContainer(
          gradientColors: [
            Colors.transparent,
            Colors.transparent,
            darkGradientColor,
          ],
          child: Image.asset(
            place.imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      );

  Widget _buildTabBarView() => TabBarView(
        children: <Widget>[
          AboutTab(place: place),
          PlaceCardsTab(place: place),
        ],
      );
}
