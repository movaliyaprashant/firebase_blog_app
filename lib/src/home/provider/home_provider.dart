import 'package:comapny_task/src/home/model/blog_data_model.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  String _selectedCategory = "All";

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String value) {
    _selectedCategory = value;
    notifyListeners();
  }
}
