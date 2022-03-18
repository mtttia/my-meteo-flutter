import 'dart:convert';
import 'dart:io';

import 'package:mymeteo/class/City.dart';
import 'package:mymeteo/util/fileManager.dart';

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

  Setting(this.favouriteCity) : favourites = [];
  Setting.empty() : favourites = [];
  Setting.fromJson(Map<String, dynamic> json)
      : favouriteCity = City.fromJson(json['favouriteCity']),
        favourites = City.listFromJson(json['favourites']);

  static load() async {
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
    await FileManager.save(jsonEncode(toJson()));
  }

  Future<bool> isInitialized() async {
    File file = await FileManager.getFile();
    return file.exists();
  }

  bool isSelected() {
    return !(favouriteCity == null);
  }

  String get cityName {
    return favouriteCity == null ? "" : favouriteCity!.name;
  }
}
