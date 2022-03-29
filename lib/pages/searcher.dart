import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mymeteo/class/City.dart';
import 'package:mymeteo/components/SearchCityList.dart';
import 'package:mymeteo/pages/weatherCity.dart';
import 'package:mymeteo/palette.dart';

class SearcherRoute extends MaterialPageRoute<void> {
  SearcherRoute({required this.toSearch})
      : super(builder: (BuildContext context) {
          return Searcher(
            toSearch: toSearch,
          );
        });
  String toSearch;
}

class Searcher extends StatefulWidget {
  Searcher({Key? key, required this.toSearch}) : super(key: key);
  String toSearch;
  @override
  State<Searcher> createState() => _SearcherState();
}

class _SearcherState extends State<Searcher> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    searchController = TextEditingController(text: widget.toSearch);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: lightBlue,
          elevation: 2,
          title: Text(
            'Cerca la tua città',
            style: GoogleFonts.openSans(),
          ),
          foregroundColor: Colors.black,
        ),
        body: Column(
          children: [
            SizedBox(
              height: height * 0.2,
              child: SafeArea(
                child: Container(
                  color: lightBlue,
                  // child: Text(widget.toSearch)
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      child: Stack(
                        children: [
                          Positioned(
                              bottom: 20,
                              left: 0,
                              right: 0,
                              child: Container(
                                  alignment: Alignment.center,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 30),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  height: 65,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 10),
                                            blurRadius: 50,
                                            color:
                                                Colors.black38.withOpacity(0.2))
                                      ]),
                                  child: Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: [
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(18)),
                                            child: TextField(
                                              controller: searchController,
                                              decoration: const InputDecoration(
                                                  hintText: 'città',
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none),
                                            ),
                                          )),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                            onPressed: () {
                                              setState(() {});
                                            },
                                            icon: const Icon(Icons.search)),
                                      )
                                    ],
                                  ))),
                        ],
                      )),
                ),
              ),
            ),
            SearchCityList(
                toSearch: searchController.text,
                onFound: (City obj) {
                  Navigator.of(context).push(WeatherCityRoute(city: obj));
                })
          ],
        ));
  }
}
