import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:travel_ui/ui/styles/index.dart';

import 'package:travel_ui/models/category.dart';
import 'package:travel_ui/providers/category_provider.dart';

import 'package:travel_ui/ui/widgets/common/destinations_grid.dart';

class DestinationsSearchDelegate extends SearchDelegate {
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
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    List<Category> results = [];

    if (query != '') {
      results = categoryProvider.getByTitle(query);
    }

    return results.isEmpty
        ? Center(
            child: Text(
              "Nothing to show..",
              style: smallTextStyle,
            ),
          )
        : DestinationsGrid(
            categories: results,
          );
  }
}
