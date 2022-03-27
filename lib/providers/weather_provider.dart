import 'package:flutter/material.dart';

class Weather with ChangeNotifier {
  Map<int, Map<String, dynamic>> _weathers = {};

  bool get empty => !_weathers.isNotEmpty;

  Map<int, Map<String, dynamic>> get weathers => _weathers;

  pushWeather(int cityId, Map<String, dynamic> w) {
    _weathers.addAll({cityId: w});
    notifyListeners();
  }
}
