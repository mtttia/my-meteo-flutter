import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:mymeteo/class/City.dart';
import 'package:mymeteo/util/fileManager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingLoader {
  bool isLoading = true;
  Setting? setting;

  static Future<Setting> load() async {
    return await Setting.tryLoad();
  }
}

class Setting {
  City? favouriteCity;
  List<City> favourites;
  List<City> get allFavourites {
    List<City> ret = List<City>.from(favourites);
    if (favouriteCity != null) ret.add(favouriteCity!);
    return ret;
  }

  String get cityName {
    return favouriteCity == null ? "" : favouriteCity!.name;
  }

  Setting(this.favouriteCity) : favourites = [];
  Setting.empty() : favourites = [];
  Setting.fromJson(Map<String, dynamic> json)
      : favouriteCity = City.fromJson(json['favouriteCity']),
        favourites = City.listFromJson(json['favourites']);

  static load() async {
    if (kIsWeb) {
      return Setting.fromJson(jsonDecode((await getItem('setting')) as String));
    }
    return Setting.fromJson(jsonDecode(await FileManager.load()));
  }

  static Future<Setting> tryLoad() async {
    try {
      return await Setting.load();
    } catch (e) {
      print(e);
      return Setting.empty();
    }
  }

  Map<String, dynamic> toJson() {
    return {'favouriteCity': favouriteCity, 'favourites': favourites};
  }

  addFavourites(City c) {
    if (favourites.contains(c) && favouriteCity != c) {
      favourites.add(c);
    }
  }

  updateCity(City newCity) {
    favouriteCity = newCity;
    save();
  }

  save() async {
    if (kIsWeb) {
      await setItem('setting', jsonEncode(toJson()));
    }
    else{
      await FileManager.save(jsonEncode(toJson()));
    }
  }

  Future<bool> isInitialized() async {
      if (kIsWeb) {
        return await hasItem('setting');
      }
      File file = await FileManager.getFile();
      return file.exists();
    }

    bool isSelected() {
      return !(favouriteCity == null);
    }
}

//method that check if a browser local storage item exists
  Future<bool> hasItem(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

//method to acces to the browser local storage item, given the key
  Future<String?> getItem(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

//method to set the browser local storage item, given the key and the value
  Future<bool> setItem(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }