import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:travel_ui/ui/styles/index.dart';

import 'package:travel_ui/models/place.dart';
import 'package:travel_ui/providers/place_provider.dart';

import 'package:travel_ui/ui/widgets/common/discover_card.dart';

class PlaceSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildDestinations(context, query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildDestinations(context, query);
  }

  Widget _buildDestinations(BuildContext context, String query) {
    PlaceProvider placeProvider = Provider.of<PlaceProvider>(context);
    List<Place> results = [];

    if (query != '') {
      results = placeProvider.getByTitle(query);
    }

    return results.isEmpty
        ? Center(
            child: Text(
              "Nothing to show..",
              style: smallTextStyle,
            ),
          )
        : ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            itemCount: results.length,
            itemBuilder: (BuildContext context, int index) => DiscoverCard(
              place: results[index],
              index: index,
            ),
          );
  }
}
