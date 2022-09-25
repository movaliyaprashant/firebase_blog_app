import 'package:comapny_task/src/create_blog/provider/create_blog_provider.dart';
import 'package:comapny_task/src/home/provider/home_provider.dart';
import 'package:comapny_task/src/login/provider/login_provider.dart';
import 'package:comapny_task/src/profile/provider/profile_provider.dart';
import 'package:comapny_task/src/search/provider/search_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ProviderBind{
  static List<SingleChildWidget> providers=[
    ChangeNotifierProvider<LogInProvider>(create: (_) =>LogInProvider(),),
    ChangeNotifierProvider<ProfileProvider>(create: (_) =>ProfileProvider(),),
    ChangeNotifierProvider<HomeProvider>(create: (_) =>HomeProvider()),
    ChangeNotifierProvider<CreateBlogProvider>(create: (_) =>CreateBlogProvider(),),
    ChangeNotifierProvider<SearchProvider>(create: (_) =>SearchProvider(),),

  ];
}