import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/screens/news_screen.dart';
import 'package:news_app/statemanagement/brain.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = (CacheHelper.getData(key: 'isDark'));

  runApp(
    ChangeNotifierProvider(
      create: (ctx) => Brain(),
      child: MyApp(isDark),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    print('Helo');
    var p = Provider.of<Brain>(context, listen: false)
        .changeTheme(fromShared: isDark);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.deepOrange,
        ),
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.deepOrange,
        appBarTheme: AppBarTheme(
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
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
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
        ),
      ),
      themeMode: Provider.of<Brain>(context, listen: false).isDark
          ? ThemeMode.dark
          : ThemeMode.light,
      darkTheme: ThemeData(
        // HexColor('333739')
        scaffoldBackgroundColor: Color(0xFF333739),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.deepOrange,
        ),
        primarySwatch: Colors.deepOrange,
        appBarTheme: AppBarTheme(
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            // HexColor('333739')
            statusBarColor: Color(0xFF333739),
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
            // systemNavigationBarColor: Color(0xFF333739),
          ),
          // HexColor('333739')
          backgroundColor: Color(0xFF333739),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.deepOrange,
          unselectedItemColor: Colors.grey,
          // HexColor('333739')
          backgroundColor: Color(0xFF333739),
        ),
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      title: 'News App',
      home: NewsScreen(),
    );
  }
}
