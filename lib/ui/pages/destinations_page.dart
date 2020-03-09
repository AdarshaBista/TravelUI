import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:travel_ui/ui/styles/index.dart';

import 'package:travel_ui/providers/category_provider.dart';

import 'package:travel_ui/ui/widgets/common/header.dart';
import 'package:travel_ui/ui/widgets/common/search_box.dart';
import 'package:travel_ui/ui/widgets/common/destinations_grid.dart';
import 'package:travel_ui/ui/widgets/destinations_page/destinations_search_delegate.dart';

class DestinationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              _buildAppBar(),
              _buildHeader(),
            ];
          },
          body: DestinationsGrid(
            categories: Provider.of<CategoryProvider>(context).categories,
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() => SliverAppBar(
        backgroundColor: Colors.transparent,
        iconTheme: primaryIconTheme,
        elevation: 0.0,
        floating: true,
        snap: true,
        title: SearchBox(
          hintText: "Search Destinations",
          searchDelegate: DestinationsSearchDelegate(),
        ),
      );

  Widget _buildHeader() => SliverToBoxAdapter(
        child: Header(
          title: "Choose your",
          boldTitle: "Destination",
        ),
      );
}
