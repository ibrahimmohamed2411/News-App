import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/network/local/cache_helper.dart';
import 'package:news_app/screens/business_screen.dart';
import 'package:news_app/screens/science_screen.dart';
import 'package:news_app/screens/settings_screen.dart';
import 'package:news_app/screens/sports_screen.dart';

enum Category { business, sports, science }

class Brain extends ChangeNotifier {
  static String notFoundImage =
      'https://image.flaticon.com/icons/png/512/1234/1234458.png';
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
  ];

  List<Widget> _screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];

  bool _isDark = false;
  bool get isDark => _isDark;
  void changeTheme({bool? fromShared}) {
    if (fromShared != null)
      _isDark = fromShared;
    else
      _isDark = !_isDark;
    CacheHelper.putData(key: 'isDark', value: _isDark);
  }

  set isDark(bool value) {
    _isDark = value;
  }

  void getbool() async {
    _isDark = (await CacheHelper.getData(key: 'isDark'))!;
  }

  Future<List<dynamic>> getData(Category category) async {
    if (category == Category.business && business.length > 0) return business;
    if (category == Category.sports && sports.length > 0) return sports;
    if (category == Category.science && science.length > 0) return science;

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
