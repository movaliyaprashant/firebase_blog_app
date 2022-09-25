import 'dart:async';

import 'package:comapny_task/src/create_blog/model/blog_data_model.dart';
import 'package:comapny_task/src/home/view/home_screen.dart';
import 'package:comapny_task/src/login/view/log_in_screen.dart';
import 'package:comapny_task/utilities/data_base/data_base.dart';
import 'package:comapny_task/utilities/variable_utilities/variable_utilities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
late Timer timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      var token = VariableUtilities.sharedPreferences.get("token");
      print("TOKEN AT SPLASH SCREEN ===>>>$token");
      if (token != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  //LogInScreen()
                  StreamProvider<List<BlogDataModel>>.value(
                      value: DataBase.blogData,
                      child: HomeScreen(),
                      initialData: []),
            ));
      } else {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LogInScreen(),
            ));
      }
      timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    VariableUtilities.size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: VariableUtilities.size.height,
        width: VariableUtilities.size.width,
        color: Colors.red.withOpacity(0.2),
      ),
    );
  }
}
