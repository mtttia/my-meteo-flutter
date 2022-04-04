import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:mymeteo/class/City.dart';
import 'package:mymeteo/class/FileAssistant.dart';

FileAssistant fa = FileAssistant('setting.json');

class Setting with ChangeNotifier {
  City? favouriteCity;
  List<City> favourites = [];
  List<City> chronology = [];
  bool isLoaded = false;
  bool firstTime = true;
  String get cityName {
    return favouriteCity == null ? "" : favouriteCity!.name;
  }

  List<City> get allFavourites {
    List<City> ret = List<City>.from(favourites);
    if (favouriteCity != null) ret.add(favouriteCity!);
    print(ret.map((e) => e.id).toList());
    return ret;
  }

  Setting() {
    load();
  }

  Setting.fromJson(Map<String, dynamic> json)
      : favouriteCity = City.fromJson(json['favouriteCity']),
        favourites = City.listFromJson(json['favourites']),
        chronology = City.listFromJson(json['chronology']);

  loadFromJson(String json) {
    try {
      favouriteCity = City.fromJson(jsonDecode(json)['favouriteCity']);
      favourites = City.listFromJson(jsonDecode(json)['favourites']);
      chronology = City.listFromJson(jsonDecode(json)['chronology']);
    } catch (ex) {
      chronology = [];
    }
  }

  void load() async {
    try {
      String json;
      json = await fa.load();
      loadFromJson(json);
      isLoaded = true;
      firstTime = false;
      notifyListeners();
    } catch (ex) {
      //initialize new Setting
      firstTime = true;
      isLoaded = true;
      notifyListeners();
    }
  }

  updateCity(City newCity) {
    favouriteCity = newCity;
    save();
  }

  isFavourite(int cityId) {
    bool favourite = favourites.any((c) => c.id == cityId);
    if (favourite) {
      return favourite;
    } else {
      return favouriteCity?.id == cityId;
    }
  }

  removeFavourite(int cityId) {
    favourites.removeWhere((c) => c.id == cityId);
  }

  addFavourite(City c) {
    if (!favourites.contains(c) && favouriteCity != c) {
      favourites.add(c);
    }
  }

  toggleFavourite(City city) {
    var cityId = city.id;
    if (isFavourite(cityId)) {
      removeFavourite(cityId);
    } else {
      addFavourite(city);
    }
    save();
    notifyListeners();
  }

  save() async {
    await fa.setData(jsonEncode(toJson()));
  }

  Map<String, dynamic> toJson() {
    return {
      'favouriteCity': favouriteCity,
      'favourites': favourites,
      'chronology': chronology
    };
  }
}
