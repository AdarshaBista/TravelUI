import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:travel_ui/ui/styles/index.dart';

import 'package:travel_ui/providers/place_provider.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:travel_ui/ui/widgets/common/search_box.dart';
import 'package:travel_ui/ui/widgets/common/custom_appbar.dart';
import 'package:travel_ui/ui/widgets/common/gradient_container.dart';
import 'package:travel_ui/ui/widgets/home_page/circular_button.dart';
import 'package:travel_ui/ui/widgets/home_page/places_list.dart';
import 'package:travel_ui/ui/widgets/home_page/place_search_delegate.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController;
  bool _showSearchIcon = false;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_toggleSearchIcon);
  }

  void _toggleSearchIcon() {
    final double searchBarHeight = MediaQuery.of(context).size.height * 0.3;
    if (_scrollController.position.pixels > searchBarHeight && !_showSearchIcon) {
      setState(() {
        _showSearchIcon = true;
      });
    }

    if (_scrollController.position.pixels < searchBarHeight && _showSearchIcon) {
      setState(() {
        _showSearchIcon = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(
        title: "TRAVEL",
      ),
      floatingActionButton: _showSearchIcon ? _buildSearchFab() : null,
      body: ListView(
        controller: _scrollController,
        children: <Widget>[
          _buildHeader(),
          _buildButtonRow(),
          SizedBox(height: 16.0),
          ..._buildPlacesList(context),
        ],
      ),
    );
  }

  Widget _buildSearchFab() => FloatingActionButton(
        backgroundColor: primaryColor,
        elevation: 8.0,
        child: Icon(
          Icons.search,
          color: Colors.white,
        ),
        onPressed: () {
          showSearch(context: context, delegate: PlaceSearchDelegate());
        },
      );

  Widget _buildHeader() => Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          _buildCarousel(),
          _buildSearchBox(),
        ],
      );

  Widget _buildCarousel() => GradientContainer(
        height: MediaQuery.of(context).size.height * 0.35,
        gradientColors: [
          Colors.transparent,
          Colors.transparent,
          primaryColor,
        ],
        child: Consumer<PlaceProvider>(
          builder: (BuildContext context, PlaceProvider placeProvider, _) => Swiper(
            autoplay: true,
            autoplayDelay: 2000,
            itemCount: placeProvider.places.length,
            itemBuilder: (BuildContext context, int index) => Image.asset(
              placeProvider.places[index].imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );

  Widget _buildSearchBox() => Container(
        color: Colors.transparent,
        padding: const EdgeInsets.all(16.0),
        child: SearchBox(
          hintText: "Where do you want to go?",
          searchDelegate: PlaceSearchDelegate(),
        ),
      );

  Widget _buildButtonRow() => Container(
        padding: EdgeInsets.only(top: 8.0, bottom: 20.0),
        color: primaryColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircularButton(
              title: "My Trips",
              iconData: Icons.map,
              backgroundColor: Colors.red,
              onPressed: () {},
            ),
            CircularButton(
              title: "Package",
              iconData: Icons.card_travel,
              backgroundColor: Colors.cyan,
              onPressed: () {},
            ),
            CircularButton(
              title: "Where to Stay",
              iconData: Icons.hotel,
              backgroundColor: Colors.lightGreen,
              onPressed: () {},
            ),
            CircularButton(
              title: "Nearby Places",
              iconData: Icons.fastfood,
              backgroundColor: Colors.orange,
              onPressed: () {},
            ),
            CircularButton(
              title: "Travel Guide",
              iconData: Icons.flight_takeoff,
              backgroundColor: Colors.purple,
              onPressed: () {},
            ),
          ],
        ),
      );

  List<Widget> _buildPlacesList(BuildContext context) {
    PlaceProvider placeProvider = Provider.of<PlaceProvider>(context);

    return [
      PlacesList(
        title: "Top Rated",
        index: 0,
        places: placeProvider.getTopRated(),
      ),
      PlacesList(
        title: "Nearby",
        index: 1,
        places: placeProvider.getNearby(),
      ),
      PlacesList(
        title: "Where to Stay",
        index: 2,
        places: placeProvider.getByCategory("Mountains"),
      ),
    ];
  }
}
