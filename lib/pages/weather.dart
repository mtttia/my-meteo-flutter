import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mymeteo/class/City.dart';

class Weather extends StatefulWidget {
  Weather({Key? key, required this.city}) : super(key: key);
  City city;

  @override
  State<Weather> createState() => WeatherState();
}

class WeatherState extends State<Weather> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
