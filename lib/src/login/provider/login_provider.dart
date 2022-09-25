import 'package:comapny_task/utilities/variable_utilities/variable_utilities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogInProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future<String?> logInWithEmail() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      VariableUtilities.sharedPreferences
          .setString("token", credential.user!.uid);
      VariableUtilities.sharedPreferences.setString("logInType", "Email");
      return "LogIn Successfully";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        return "Wrong password provided";
      } else {
        return null;
      }
    }
  }

  Future<String?> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        VariableUtilities.sharedPreferences
            .setString("token", userCredential.user!.uid);
        VariableUtilities.sharedPreferences.setString("logInType", "Gmail");
        return "LogIn Successfully";
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          return "Account-exists";
        } else if (e.code == 'invalid-credential') {
          return "Invalid Email";
        }
      } catch (e) {
        print("ERRROR====>>>>>>>>>>> $e");
        return "Server Error";
      }
    }
  }
}
