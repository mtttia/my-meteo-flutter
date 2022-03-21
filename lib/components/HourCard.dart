import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mymeteo/palette.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HourCard extends StatelessWidget {
  HourCard(this.hour, {Key? key}) : super(key: key);
  Map<String, dynamic> hour;

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(hour['dt']*1000);
    return Container(
      decoration: BoxDecoration(
        color: blue,
        borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 5),
                blurRadius: 10,
                color: Colors.black38.withOpacity(0.3))
          ]
      ),
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 25, left: 15, top: 5),
      child: Column(
        children: [
          Container(
            child: Text('${date.hour} : ${date.minute}', style: GoogleFonts.openSans()),
          ),
          Image.network('https://openweathermap.org/img/wn/${hour['weather'][0]['icon']}@2x.png'),
          Row(
            children: [
              Container(
                child: Column(
                  children: [
                    Icon(Icons.thermostat),
                    AutoSizeText('${hour['temp'].toString()}°', maxLines: 1,)
                  ],
                ),
                alignment: Alignment.centerLeft,
              ),
              // Expanded(
              //   child: Container(), 
              //   flex: 1,
              // ),
              const SizedBox(
                
                width: 20,
              ),
              Container(
                child: Column(
                  children: [
                    const Icon(Icons.water_drop),
                    AutoSizeText('${hour['pop'].toString().padRight(2, '0')}%', maxLines: 1,)
                  ],
                ),
                alignment: Alignment.centerRight,
              )
            ],
          )
        ],
      ),
    );
  }
}