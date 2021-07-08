import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/network/dio_helper.dart';
import 'package:news_app/screens/news_screen.dart';

void main() {
  DioHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.deepOrange,
        ),
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.deepOrange,
        appBarTheme: AppBarTheme(
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.red,
            statusBarIconBrightness: Brightness.dark,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepOrange,
        ),
      ),
      themeMode: ThemeMode.light,
      darkTheme: ThemeData(
        scaffoldBackgroundColor: Colors.black26,
      ),
      title: 'News App',
      home: NewsScreen(),
    );
  }
}
