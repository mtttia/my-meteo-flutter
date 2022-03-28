import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mymeteo/class/Setting.dart';
import 'package:mymeteo/components/CurrentWeather.dart';
import 'package:mymeteo/components/cityItem.dart';
import 'package:mymeteo/pages/searcher.dart';
import 'package:mymeteo/pages/weather.dart';
import 'package:mymeteo/request.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skeletons/skeletons.dart';
import 'package:mymeteo/palette.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:mymeteo/providers/weather_provider.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.setting}) : super(key: key);
  Setting? setting;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Map<String, dynamic>? weather;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? weather;
    try {
      weather = context
              .watch<Weather>()
              .weathers
              .containsKey(widget.setting!.favouriteCity!.id)
          ? context.watch<Weather>().weathers[widget.setting!.favouriteCity!.id]
          : null;
    } catch (ex) {
      weather = null;
    }

    onWeather(Map<String, dynamic>? json) {
      try {
        context
            .read<Weather>()
            .pushWeather(widget.setting!.favouriteCity!.id, json!);
      } catch (ex) {
        rethrow;
      }
    }

    loadingWeatherError(Object obj) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Errore nel caricamento dei dati'),
          content: const Text('Impossibile caricare i dati relativi al meteo'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    String favCityName = widget.setting != null ? widget.setting!.cityName : "";
    if (widget.setting != null &&
        widget.setting!.isSelected() &&
        weather == null) {
      try {
        if (context.watch<Weather>().empty ||
            !context
                .watch<Weather>()
                .weathers
                .containsKey(widget.setting!.favouriteCity!.id)) {
          loadMeteo(
                  lat: widget.setting!.favouriteCity!.coord.lat,
                  lon: widget.setting!.favouriteCity!.coord.lon)
              .then(onWeather)
              .catchError(loadingWeatherError);
        }
      } catch (ex) {
        print('error occurred_IN_HOME');
      }
    }
    return ListView(
      children: [
        Container(
            height: height * 0.4 + 21,
            decoration: const BoxDecoration(
                // color: lightBlue,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: SafeArea(
              // minimum: const EdgeInsets.all(20),
              child: Stack(children: [
                Container(
                  decoration: const BoxDecoration(
                      color: lightBlue,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(80),
                          bottomRight: Radius.circular(80))),
                  height: height * 0.4 - 25,
                  // color: lightBlue,
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.settings)),
                            ),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Skeleton(
                                      child: Container(
                                        alignment: Alignment.topRight,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              const Icon(Icons.thermostat),
                                              Text(weather != null
                                                  ? weather['current']['temp']
                                                      .toString()
                                                  : ""),
                                              // Icon(Icons.grain),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              Text(weather != null
                                                  ? weather['current']
                                                              ['weather'][0]
                                                          ['description']
                                                      .toString()
                                                  : ""),
                                            ]),
                                      ),
                                      skeleton: SkeletonListTile(),
                                      isLoading: weather == null,
                                    )))
                          ],
                        ),
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                      ),
                      SizedBox(
                        height: height * 0.3,
                        child: Row(
                          children: [
                            Expanded(
                              child: Image.asset(
                                'assets/image/mw.png',
                                width: width / 2 - 20,
                              ),
                              flex: 1,
                            ),
                            const Expanded(
                                child: AutoSizeText(
                              'My meteo',
                              maxLines: 2,
                              style: TextStyle(fontSize: 30),
                            ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(horizontal: 60),
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: 65,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 10),
                                  blurRadius: 50,
                                  color: Colors.black38.withOpacity(0.2))
                            ]),
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(18)),
                                  child: TextField(
                                    controller: searchController,
                                    decoration: const InputDecoration(
                                        hintText: 'città',
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none),
                                  ),
                                )),
                            Container(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(SearcherRoute(
                                        toSearch: searchController.text));
                                  },
                                  icon: const Icon(Icons.search)),
                            )
                          ],
                        ))),
              ]),
            )),
        Stack(
            children: widget.setting != null
                ? widget.setting!.allFavourites
                    .map((e) => Hero(
                      tag: 'cityItem',
                      child: CityItem(
                        onClick: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: Hero(WeatherCity(city: e,), tag: 'cityItem')),
                          )
                        },
                        cityName: e.name))
                    )
                    .toList()
                : [
                    Skeleton(
                        isLoading: true,
                        skeleton: SkeletonListTile(),
                        child: Container())
                  ]),
        Container(
          margin: EdgeInsets.only(top: 15),
          child: widget.setting != null
              ? CurrentWeather(
                  weather: weather,
                  city: widget.setting!.favouriteCity,
                  isLoading: weather == null)
              : Container(),
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}
