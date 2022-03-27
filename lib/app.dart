import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mymeteo/class/Setting.dart';
import 'package:mymeteo/pages/favouriteCity.dart';
import 'package:mymeteo/palette.dart';
import 'package:mymeteo/request.dart';
import 'package:mymeteo/view/counter.dart';
import 'package:mymeteo/view/home.dart';
import 'package:mymeteo/util/fileManager.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

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
      CounterPage(),
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
      bottomNavigationBar:Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        decoration: BoxDecoration(
            color: background,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
            borderRadius: const BorderRadius.all(Radius.circular(40))),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 1),
            child: BottomNavyBar(
              selectedIndex: _selectedIndex,
              showElevation: false, // use this to remove appBar's elevation
              onItemSelected: (index) => setState(() {
                _selectedIndex = index;
                // _pageController.animateToPage(index,duration: Duration(milliseconds: 300), curve: Curves.ease);
              }),
              items: [
                BottomNavyBarItem(
                  icon: Icon(Icons.home),
                  title: Text('Home'),
                  activeColor: Colors.black,
                ),
                BottomNavyBarItem(
                    icon: Icon(Icons.people),
                    title: Text('Users'),
                  activeColor: Colors.black,
                ),
                BottomNavyBarItem(
                    icon: Icon(Icons.message),
                    title: Text('Messages'),
                  activeColor: Colors.black,
                ),
                BottomNavyBarItem(
                    icon: Icon(Icons.settings),
                    title: Text('Settings'),
                  activeColor: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*
* old navigation bar
*
*
* */