import 'package:flutter/material.dart';

import 'package:travel_ui/ui/styles/index.dart';

import 'package:travel_ui/ui/transitions/villain_translate.dart';
import 'package:travel_ui/ui/widgets/common/custom_card.dart';

class SearchBox extends StatelessWidget {
  final SearchDelegate searchDelegate;
  final String hintText;

  SearchBox({
    @required this.searchDelegate,
    this.hintText = "",
  }) : assert(searchDelegate != null);

  @override
  Widget build(BuildContext context) {
    return VillainTranslate(
      child: GestureDetector(
        onTap: () {
          showSearch(context: context, delegate: searchDelegate);
        },
        child: CustomCard(
          elevation: 4.0,
          borderRadius: 8.0,
          child: _buildSearchContainer(context),
        ),
      ),
    );
  }

  Widget _buildSearchContainer(BuildContext context) => Container(
        width: double.infinity,
        height: 48.0,
        child: Row(
          children: <Widget>[
            SizedBox(width: 12.0),
            Icon(Icons.search),
            SizedBox(width: 12.0),
            Text(
              hintText,
              style: smallTextStyle,
            ),
          ],
        ),
      );
}
