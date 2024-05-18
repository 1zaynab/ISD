/*
import 'package:flutter/material.dart';

import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
*/


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retrievee/pages/interest_page.dart';
import 'package:retrievee/pages/liked_page.dart';
import 'package:retrievee/pages/notification_page.dart';
import 'package:retrievee/pages/saved_page.dart';
import 'package:retrievee/pages/search_page.dart';
import 'package:retrievee/screens/custom_navigation_bar.dart';
import 'package:retrievee/selected_category/selected_categories.dart';
import 'package:retrievee/themeapp/appthemes.dart';
import 'classes/article.dart';
import 'tweet_service.dart';
import 'pages/home_page.dart';


class ThemeState extends ChangeNotifier {
  ThemeData _themeData = AppThemes.lightTheme;

  ThemeData get themeData => _themeData;

  void toggleTheme() {
    _themeData = _themeData == AppThemes.lightTheme ? AppThemes.darkTheme : AppThemes.lightTheme;
    notifyListeners();
  }
}
void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeState()),
      ChangeNotifierProvider(create: (context) => SelectedCategories()),
      Provider(create: (context) => APIService(baseUrl: 'http://10.0.2.2:5000')),

    ],
    child: MyApp(),
  ));
}


class MyApp extends StatelessWidget {
  final APIService apiService = APIService(baseUrl: 'http://10.0.2.2:5000');

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Twitter App',
      theme: Provider.of<ThemeState>(context).themeData,
      home: MyHomePage(
        name: 'Twitter Feed',
        apiService: apiService,
      ),

    routes: {
        '/search' : (context) => SearchPage(),
       '/saved' : (context) =>  SavedPage(),
      '/interest': (context) => const InterestPage(),
      '/notification': (context) => const NotificationPage(),
      '/liked' : (context) =>  LikedPage(),
    },
    );
  }
}

/*class MyHomePage extends StatelessWidget {
  final String name;
  final APIService apiService;

  MyHomePage({required this.name, required this.apiService});

  @override
  Widget build(BuildContext context) {
    return HomePage(title: name, apiService: apiService);

    //return SearchPage();
  }
}*/


class MyHomePage extends StatelessWidget {
  final String name;
  final APIService apiService;

  MyHomePage({super.key, required this.name, required this.apiService});

  @override
  Widget build(BuildContext context) {
    return CustomNavigationBar(title: name, apiService: apiService,);
  }
}
