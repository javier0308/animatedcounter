import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;
  static int _counter = 0;
  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static int get counter {
    return _prefs.getInt('counter') ?? _counter;
  }

  static set counter(int value) {
    _counter = value;
    _prefs.setInt('counter', value);
  }
}
