import 'package:flutter/material.dart';
import 'package:mymeteo/class/City.dart';
import 'package:mymeteo/components/cityCard.dart';
import 'package:mymeteo/util/city.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:mymeteo/view/home.dart';

class SearchCityList extends StatefulWidget {
  SearchCityList({Key? key, required this.toSearch, required this.onFound})
      : super(key: key);
  String toSearch;
  void Function(City) onFound;

  @override
  State<SearchCityList> createState() => _SearchCityListState();
}

class _SearchCityListState extends State<SearchCityList> {
  void onCitySelected(Map<String, dynamic> citySelected) {
    City city = City.fromJson(citySelected);
    widget.onFound(city);
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> ret = searchCity(city, widget.toSearch);
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var r in ret)
            CityCard(
                city: r,
                onPress: () {
                  onCitySelected(r);
                  Navigator.of(context).pop();
                })
        ],
      ),
    );
  }
}

List<Map<String, dynamic>> searchCity(
    List<Map<String, dynamic>> cityes, String toSearch) {
  var ret = <Map<String, dynamic>>[];
  for (var c in cityes) {
    if (c['name'].toString().toUpperCase().contains(toSearch.toUpperCase())) {
      ret.add(c);
    }
  }
  return ret;
}
