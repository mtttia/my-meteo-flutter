import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mymeteo/class/City.dart';
import 'package:mymeteo/components/HourCard.dart';
import 'package:mymeteo/palette.dart';
import 'package:skeletons/skeletons.dart';
import 'package:stack_trace/stack_trace.dart';

class CurrentWeather extends StatelessWidget {
  CurrentWeather(
      {Key? key,
      required this.weather,
      required this.city,
      required this.isLoading})
      : super(key: key);
  Map<String, dynamic>? weather;
  City? city;
  bool isLoading;

  @override
  Widget build(BuildContext context) {

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: lightBlue),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
        child: weather == null || city == null
            ? Skeleton(
                isLoading: isLoading,
                skeleton: SkeletonListTile(),
                child: Container())
            : Container(
                child: Column(children: [
                Row(
                  children: [
                    Container(
                      child: Text(city!.name,
                          style: GoogleFonts.openSans(
                              textStyle: const TextStyle(fontSize: 22))),
                      alignment: Alignment.centerLeft,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Container(
                      child: Text(
                          weather!['current']['weather'][0]['description']),
                      alignment: Alignment.centerRight,
                    )
                  ],
                ),
                const SizedBox(height: 30,),
                SizedBox(
                  height: 240,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List<dynamic>.from(
                              weather!['hourly'] as List<dynamic>).where((e)=>DateTime.fromMillisecondsSinceEpoch(e['dt']*1000).day == DateTime.now().day).toList().map((e) => HourCard(e)).toList()),                             
                ),
              ])));
  }
}
