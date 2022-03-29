import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mymeteo/palette.dart';
import 'package:provider/provider.dart';
import 'package:mymeteo/class/City.dart';
import 'package:provider/provider.dart';
import 'package:mymeteo/providers/setting.dart';

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
    var setting = context.watch<Setting>();

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: lightBlue,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        body: Column(
          children: [
            Container(
              child: Row(
                children: [
                  Text(
                    widget.city.name,
                    style: GoogleFonts.openSans(
                      fontSize: 40,
                      color: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: Icon(setting.isFavourite(widget.city.id) ? Icons.favorite : Icons.favorite_border),
                        onPressed: () {
                          context.read<Setting>().toggleFavourite(widget.city);
                        },
                      ),
                    ),
                    flex: 1,
                  )
                ],
              ),
              color: lightBlue,
              width: width,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
          ],
        ));
  }
}
