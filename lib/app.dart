import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mymeteo/class/Setting.dart';
import 'package:mymeteo/pages/favouriteCity.dart';
import 'package:mymeteo/palette.dart';
import 'package:mymeteo/request.dart';
import 'package:mymeteo/view/home.dart';
import 'package:mymeteo/util/fileManager.dart';

import 'class/City.dart';

class App extends StatefulWidget {
  App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _selectedIndex = 0;
  Map<String, dynamic>? weather;
  Setting? setting;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);

  Future<void> askCity(BuildContext context) async {
    if (!(await setting!.isInitialized())) {
      Navigator.of(context).push(FavouriteCityRoute(onFound: (City city) {
        setting!.updateCity(city);
        setState(() {});
      }));
    }
  }

  void settinIsLoaded(Setting value) async {
    setState(() {
      setting = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (setting == null) {
      Setting.tryLoad().then(settinIsLoaded);
    } else {
      if (!setting!.isSelected()) {
        askCity(context);
      }
    }

    List<Widget> _widgetOptions = <Widget>[
      Home(
        setting: setting,
      ),
      Text(
        'Likes',
        style: optionStyle,
      ),
      Text(
        'Search',
        style: optionStyle,
      ),
      Text(
        'Profile',
        style: optionStyle,
      ),
    ];

    return Scaffold(
      backgroundColor: background,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        decoration: BoxDecoration(
            color: background,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.favorite,
                  text: 'Likes',
                ),
                GButton(
                  icon: Icons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
