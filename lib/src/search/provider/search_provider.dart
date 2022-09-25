import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  List<String> _filterData = [];

  List<String> get filterData => _filterData;

  set filterData(List<String> value) {
    _filterData = value;
    notifyListeners();
  }

  List<String> categoryList = [];

  TextEditingController searchController = TextEditingController();
  String _selectedCategory = "All";

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String value) {
    _selectedCategory = value;
    searchController.clear();
    filterData.clear();
    notifyListeners();
  }

  void searchData({required String a}) {
    if (a == null || a.isEmpty || a == "") {
      filterData.clear();
    } else {
      filterData = categoryList.toSet().toList().where((element) {
        if (element.toLowerCase().contains(a.toLowerCase())) {
          return true;
        } else {
          return false;
        }
      }).toList();
    }
    notifyListeners();
  }

  Future getAllData({required String category}) async {
    categoryList.clear();
    QuerySnapshot data =
        await FirebaseFirestore.instance.collection('blogs').get();

    if (category == "User") {
      data.docs.forEach((element) {
        categoryList.add(element["userName"]);
      });
    } else if (category == "Email") {
      data.docs.forEach((element) {
        categoryList.add(element["email_id"]);
      });
    } else {
      data.docs.forEach((element) {
        categoryList.add(element["userName"]);
        categoryList.add(element["email_id"]);
      });
    }
    notifyListeners();
  }
}
