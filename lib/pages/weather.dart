import 'package:flutter/material.dart';
import 'package:mymeteo/palette.dart';
import 'package:provider/provider.dart';
import 'package:mymeteo/class/City.dart';

class WeatherCityRoute extends MaterialPageRoute<void> {
  WeatherCityRoute({required this.city})
      : super(builder: (BuildContext context) {
          return WeatherCity(
            city: city,
          );
        });
  City city;
}

class WeatherCity extends StatefulWidget {
  WeatherCity({Key? key, required this.city}) : super(key: key);
  City city;

  @override
  State<WeatherCity> createState() => WeatherCityState();
}

class WeatherCityState extends State<WeatherCity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightBlue,
        elevation: 2,
        foregroundColor: Colors.black,
      ),
      body: Container(child: Text(widget.city.name)),
    );
  }
}
