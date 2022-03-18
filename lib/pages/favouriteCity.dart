import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mymeteo/components/SearchCityList.dart';
import 'package:mymeteo/palette.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../class/City.dart';

class FavouriteCityRoute extends MaterialPageRoute<void> {
  FavouriteCityRoute({required this.onFound})
      : super(builder: (BuildContext context) {
          return FavCity(onFound: onFound);
        });

  void Function(City) onFound;
}

class FavCity extends StatefulWidget {
  FavCity({Key? key, required this.onFound}) : super(key: key);
  void Function(City) onFound;

  @override
  State<FavCity> createState() => _FavCityState();
}

class _FavCityState extends State<FavCity> {
  TextEditingController toSearch = TextEditingController(text: 'cesena');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBrown,
      appBar: AppBar(
        backgroundColor: lightBrown,
        elevation: 0,
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(20),
        child: ListView(
          children: [
            AutoSizeText(
              'Seleziona la tua città preferita',
              style: GoogleFonts.openSans(color: background, fontSize: 50),
              maxLines: 2,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                padding: EdgeInsets.fromLTRB(30, 2, 30, 2),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        color: Colors.black.withOpacity(.1),
                      )
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: background),
                child: TextField(
                  controller: toSearch,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Cerca una città',
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {});
                },
                child: Text(
                  'CERCA',
                  style: TextStyle(color: text),
                ),
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    fixedSize: Size.infinite,
                    primary: blue),
              ),
            ),
            SearchCityList(
              toSearch: toSearch.text,
              onFound: widget.onFound,
            )
          ],
        ),
      ),
    );
  }
}
