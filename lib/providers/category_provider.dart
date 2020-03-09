import 'package:travel_ui/models/category.dart';

import 'package:travel_ui/data/data.dart';

class CategoryProvider {
  List<Category> _categories = dummyCategories;
  List<Category> get categories => _categories;

  Category getById(int id) => _categories.firstWhere((category) => category.id == id);

  List<Category> getByTitle(String title) =>
      _categories.where((category) => category.title.toLowerCase().contains(title.toLowerCase())).toList();

  List<Category> getByRating(double rating) => _categories.where((category) => category.rating >= rating).toList();

  List<Category> getTopRated() => getByRating(4.0);
}
