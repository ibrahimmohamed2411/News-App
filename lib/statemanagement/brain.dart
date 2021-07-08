import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/network/dio_helper.dart';
import 'package:news_app/screens/business_screen.dart';
import 'package:news_app/screens/science_screen.dart';
import 'package:news_app/screens/settings_screen.dart';
import 'package:news_app/screens/sports_screen.dart';

enum Category { business, sports, science }

class Brain extends ChangeNotifier {
  int _currentIndex = 0;
  String _API_KEY = 'c51417b837f947929f32ae66e909c217';
  List<BottomNavigationBarItem> _bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: 'Science',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  List<Widget> _screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  Future<List<dynamic>> getBusiness(Category category) async {
    final response = await DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': category.toString().split('.').last.toString(),
        'apiKey': _API_KEY,
      },
    );
    List<dynamic> list = response.data['articles'];
    if (category == Category.sports) {
      return sports = list;
    }
    if (category == Category.science) {
      return science = list;
    }
    business = list;
    return business;
  }

  List<Widget> get screens => _screens;
  void changeBottomNavigatonBar(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  int get currentIndex => _currentIndex;
  List<BottomNavigationBarItem> get bottomItems => _bottomItems;
}
