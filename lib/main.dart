import 'package:comapny_task/src/create_blog/model/blog_data_model.dart';
import 'package:comapny_task/src/home/view/home_screen.dart';
import 'package:comapny_task/src/login/view/log_in_screen.dart';
import 'package:comapny_task/src/profile/view/profile_view.dart';
import 'package:comapny_task/src/splash/view/splash_screen.dart';
import 'package:comapny_task/utilities/data_base/data_base.dart';
import 'package:comapny_task/utilities/provider/provider_binding.dart';
import 'package:comapny_task/utilities/variable_utilities/variable_utilities.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  ///This Notification for Local Device Notification
  // androidNotificationChannel() =>const AndroidNotificationChannel(
  //   'high_importance_channel', // id
  //   'High Importance Notifications', // title
  //   description: "DESC", // description
  //   importance: Importance.max,
  // );
  // const AndroidInitializationSettings initializationSettingsAndroid =  AndroidInitializationSettings('@mipmap/ic_launcher');
  // final InitializationSettings initializationSettings = InitializationSettings(
  //     android: initializationSettingsAndroid);
  // await FlutterLocalNotificationsPlugin().initialize(initializationSettings);
  // RemoteNotification? notification = message.notification;
  // AndroidNotification? android = message.notification?.android;
  //
  // AndroidNotificationChannel channel = androidNotificationChannel();
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  // FlutterLocalNotificationsPlugin();
  // flutterLocalNotificationsPlugin.show(
  //   notification.hashCode,
  //   notification?.title??"Title",
  //   notification?.body,
  //   NotificationDetails(
  //     android: AndroidNotificationDetails(
  //       channel.id,
  //       channel.name,
  //       icon: android!.smallIcon,
  //       playSound: true,
  //     ),
  //   ),
  // );
}

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  VariableUtilities.sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) async {
     /// Here on Notification Tap handle with Payload on Notification
      },
    );
  }

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
