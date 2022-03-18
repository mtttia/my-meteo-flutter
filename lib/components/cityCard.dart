import 'package:flutter/material.dart';
import 'package:mymeteo/palette.dart';

class CityCard extends StatefulWidget {
  CityCard({Key? key, required this.city, required this.onPress})
      : super(key: key);
  void Function() onPress;
  Map<String, dynamic> city;

  @override
  State<CityCard> createState() => _CityCardState();
}

class _CityCardState extends State<CityCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      decoration: BoxDecoration(
          color: lightBrown, borderRadius: BorderRadius.circular(50)),
      child: InkWell(
        autofocus: true,
        onTap:widget.onPress,
        borderRadius: BorderRadius.circular(50),
        child: Row(children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: brown),
              child: Icon(Icons.location_city, size: 40),
            ),
            Expanded(
              flex: 5,
              child: SizedBox(
                child: Container(
                alignment: Alignment.center,
                child: Text(widget.city['name']),
              ),
              )
            )
          ]),
      )
    );
  }
}
