import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comapny_task/src/create_blog/model/blog_data_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateBlogProvider extends ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<String> categoryList = ["Sport", "Movie"];
  String _selectedCategory = "Sport";

  String get selectedCategory => _selectedCategory;

  set selectedCategory(String value) {
    _selectedCategory = value;
    notifyListeners();
  }

  File? _selectedFile;

  File? get selectedFile => _selectedFile;

  set selectedFile(File? value) {
    _selectedFile = value;
    notifyListeners();
  }

  Future<String?> selectMedia() async {
    try {
      PickedFile? file =
          await ImagePicker.platform.pickImage(source: ImageSource.gallery);
      if (file != null) {
        selectedFile = File(file.path);
      } else {
        return "No Image Selected";
      }
    } catch (e) {
      return "Internal Error";
    }
  }

  String imageUrl = "";
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> uploadImage() async {
    try {
      final _firebaseStorage = FirebaseStorage.instance;
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();

      TaskSnapshot taskSnapShot = await _firebaseStorage
          .ref("blog_images/${fileName}")
          .putFile(selectedFile!);
      imageUrl = await taskSnapShot.ref.getDownloadURL();

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> addBlogData({String? imageUrl}) async {
    try {
      Map<String, dynamic> reqBody = BlogDataModel(
              title: titleController.text,
              description: descriptionController.text,
              category: selectedCategory,
              image: imageUrl,
              userName: userName ?? "Not Added",
              emailId: userEmail)
          .toJson();
      if (titleController.text.isNotEmpty &&
          descriptionController.text.isNotEmpty) {

        await FirebaseFirestore.instance.collection("blogs").add(reqBody);

        return "Blog Added Successfully";
      } else {
        return "Fill title & description";
      }
    } catch (e) {
      return "Try Again Later";
    }
  }

  String? userName = "";
  String? userEmail = "";
  Future<bool> getUserDetails() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      User? user = _auth.currentUser;
      userName = user?.displayName;
      userEmail = user?.email;
      debugPrint('CURRENT USER===>>>${user?.email}');
      debugPrint('CURRENT USER===>>>${user?.displayName}');
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
  @override
  void dispose() {
    titleController.clear();
    selectedFile=null;
    descriptionController.clear();
    selectedCategory="Sports";
    // TODO: implement dispose
    super.dispose();
  }
}
