// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';

class MapNetworkHelper {
  MapNetworkHelper(
      {required this.startLng, required this.startLat, required this.endLng, required this.endLat});

  final String url = 'https://api.openrouteservice.org/v2/directions/';
  final String apiKey = '5b3ce3597851110001cf6248d593b3cc75174831ac9afba2be182667';
  final String journeyMode = 'driving-car'; // Change it if you want or make it variable
  final double startLng;
  final double startLat;
  final double endLng;
  final double endLat;

  ///startLng.toString().trim() + ',' + startLat.toString().trim() +
  Future getData() async {
    String urlstr = '$url$journeyMode?api_key=$apiKey&start=72.571365,23.022505&end=${endLng.toString().trim()},${endLat.toString().trim()}';
    http.Response response = await http.get(Uri.parse(urlstr));
    //'$url$journeyMode?api_key=$apiKey&start=$startLng,$startLat&end=$endLng,$endLat');
    print(urlstr);
    //"$url$journeyMode?$apiKey&start=$startLng,$startLat&end=$endLng,$endLat");
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}