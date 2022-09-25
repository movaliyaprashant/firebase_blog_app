import 'package:comapny_task/utilities/variable_utilities/variable_utilities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileProvider extends ChangeNotifier {
  ProfileProvider(){
    getUserDetails();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String? _userName;

  String? get userName => _userName;

  set userName(String? value) {
    _userName = value;
    notifyListeners();
  }

  String? _userEmail;

  String? get userEmail => _userEmail;

  set userEmail(String? value) {
    _userEmail = value;
    notifyListeners();
  }
  String? _loginType;

  String? get loginType => _loginType;

  set loginType(String? value) {
    _loginType = value;
    notifyListeners();
  }

  Future<bool> getUserDetails() async {
    loginType =
    VariableUtilities.sharedPreferences.getString("logInType");

  try{
    User? user= _auth.currentUser;
    userName=user?.displayName;
    userEmail=user?.email;
    debugPrint('CURRENT USER===>>>${user?.email}');
    debugPrint('CURRENT USER===>>>${user?.displayName}');
    notifyListeners();
    return true;
  }catch(e){
   return false;
  }

  }

  Future<bool> logOut() async {
    try {
      String? logInType =
          VariableUtilities.sharedPreferences.getString("logInType");
      if (logInType == "Gmail") {
        VariableUtilities.sharedPreferences.clear();
        await _googleSignIn.signOut();
      } else {
        VariableUtilities.sharedPreferences.clear();
        await _auth.signOut();
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
