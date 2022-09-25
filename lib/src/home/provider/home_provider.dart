import 'package:comapny_task/src/home/model/blog_data_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  String _selectedCategory = "All";

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String value) {
    _selectedCategory = value;
    notifyListeners();
  }
  Future getToken()async{
    String? token = await FirebaseMessaging.instance.getToken();
    debugPrint("TOKEN=====>>>>>${token}");
  }
}
