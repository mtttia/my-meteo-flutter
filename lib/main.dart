import 'package:flutter/material.dart';
import 'package:mymeteo/app.dart';
import 'package:mymeteo/palette.dart';
import 'package:mymeteo/providers/counter.dart';
import 'package:mymeteo/providers/weather_provider.dart';
import 'package:mymeteo/request.dart';
import 'package:provider/provider.dart';
import 'package:mymeteo/providers/setting.dart';

void main() {
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Counter()), 
      ChangeNotifierProvider(create: (_)=>Weather()), 
      ChangeNotifierProvider(create: (_) => Setting(),)],
      child: MyApp()));

  //const MyApp()
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My meteo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: lightBlue,
        backgroundColor: background,
        scaffoldBackgroundColor: background,
        
      ),
      home: App(),
    );
  }
}
