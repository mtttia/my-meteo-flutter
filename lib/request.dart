import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart' as http;
import 'package:mymeteo/open_weather_key.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
/*
open_weather_key.dart

const String openWeatherKey = "open weather api key";
*/

//'https://api.openweathermap.org/data/2.5/onecall',
//?lat="$lat"&lon="$lon"&appid="$openWeatherKey"&units="metric"&lang="it"
Future<Map<String, dynamic>?> loadMeteo(
    {required String lat, required String lon}) async {
  try {
    print('REQUEST DONE');
    var url = Uri.https('api.openweathermap.org', '/data/2.5/onecall', {
      'appid': openWeatherKey,
      'lat': lat,
      'lon': lon,
      'units': 'metric',
      'lang': 'it'
    });
    var response = await http.get(url);
    print(response.statusCode);
    if (response.statusCode != 200) throw Exception('weather request error');
    return jsonDecode(response.body);
  } catch (ex) {
    print('ERROR OCCURRED');
    Future.error(ex);
  }
}
