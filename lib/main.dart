import 'package:comapny_task/src/create_blog/model/blog_data_model.dart';
import 'package:comapny_task/src/login/view/log_in_screen.dart';
import 'package:comapny_task/src/splash/view/splash_screen.dart';
import 'package:comapny_task/utilities/data_base/data_base.dart';
import 'package:comapny_task/utilities/provider/provider_binding.dart';
import 'package:comapny_task/utilities/variable_utilities/variable_utilities.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  VariableUtilities.sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderBind.providers,
      builder: (BuildContext context, Widget? child) {
        return StreamProvider<List<BlogDataModel>>.value(
          value: DataBase.blogData,
          initialData: [],
          child: MaterialApp(
            home: SplashScreen(),
          ),
        );
      },
    );
  }
}
