import 'package:flutter/material.dart';

import 'package:travel_ui/models/category.dart';

import 'package:travel_ui/ui/widgets/common/destination_card.dart';

class DestinationsGrid extends StatelessWidget {
  final List<Category> categories;

  const DestinationsGrid({
    @required this.categories,
  }) : assert(categories != null);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 10 / 14,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
      padding: EdgeInsets.all(12.0),
      shrinkWrap: true,
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) => DestinationCard(
        category: categories[index],
        index: index,
      ),
    );
  }
}
