import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mymeteo/class/City.dart';
import 'package:mymeteo/palette.dart';
import 'package:google_fonts/google_fonts.dart';

class CityItem extends StatelessWidget {
  const CityItem({Key? key, required this.onClick, required this.cityName}) : super(key: key);
  final void Function() onClick;
  final String cityName;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal:30, vertical: 15),
      // color: Colors.white,
      width: width,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 10)
            ]
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: brown.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(90)
                ),
                child: Icon(Icons.location_city, size: 30,),
              ),
              // Text(cityName, style: GoogleFonts.openSans(textStyle: TextStyle(
              //   fontSize: 18
              // )),),
              AutoSizeText(cityName, style: GoogleFonts.openSans(textStyle: const TextStyle(fontSize: 18)), maxLines: 1,)
            ],
          )
        ),
        onTap: onClick,
      )
    );
  }
}
