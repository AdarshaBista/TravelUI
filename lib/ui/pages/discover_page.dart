import 'package:flutter/material.dart';

import 'package:travel_ui/ui/styles/index.dart';

import 'package:travel_ui/models/category.dart';

import 'package:travel_ui/ui/widgets/common/header.dart';
import 'package:travel_ui/ui/widgets/common/discover_card.dart';

class DiscoverPage extends StatelessWidget {
  final Category category;

  DiscoverPage({
    @required this.category,
  }) : assert(category != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              _buildAppBar(),
            ];
          },
          body: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            itemCount: category.places.length,
            itemBuilder: (BuildContext context, int index) {
              return DiscoverCard(
                place: category.places[index],
                index: index,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() => SliverAppBar(
        backgroundColor: backgroundColor,
        iconTheme: primaryIconTheme,
        elevation: 8.0,
        floating: false,
        pinned: true,
        expandedHeight: 120.0,
        flexibleSpace: FlexibleSpaceBar(
          background: _buildHeader(),
        ),
      );

  Widget _buildHeader() => Container(
        alignment: Alignment.bottomLeft,
        child: Header(
          title: "Discover",
          boldTitle: category.title,
        ),
      );
}
