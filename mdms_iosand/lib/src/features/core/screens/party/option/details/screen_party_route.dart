// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, avoid_print, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mdms_iosand/singletons/singletons.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';

import '../../../../../../utils/mapnetwork.dart';


class PartyRoute extends StatefulWidget {
  const PartyRoute({super.key});

  @override
  _PartyRouteState createState() => _PartyRouteState();
}

class _PartyRouteState extends State<PartyRoute> {
  late GoogleMapController mapController;
  LatLng _initialPosition = const LatLng(23.0225, 72.5714);
  final List<LatLng> polyPoints = []; // For holding Co-ordinates as LatLng
  final Set<Polyline> polyLines = {}; // For holding instance of Polyline
  final Set<Marker> markers = {}; // For holding instance of Marker
  var data;
  double distance = 0.0;

  void _getUserLocation() async {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
    });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  void getJsonData() async {
    // Create an instance of Class NetworkHelper which uses http package
    // for requesting data to the server and receiving response as JSON format
    MapNetworkHelper network = MapNetworkHelper(
      startLat: _initialPosition.latitude,
      startLng: _initialPosition.longitude,
      endLat: double.parse(appData.prtlat!),
      endLng: double.parse(appData.prtlon!),
    );

    try {
      // getData() returns a json Decoded data
      data = await network.getData();
      // We can reach to our desired JSON data manually as following
      LineString ls = LineString(data['features'][0]['geometry']['coordinates']);

      for (int i = 0; i < ls.lineString.length; i++) {
        polyPoints.add(LatLng(ls.lineString[i][1], ls.lineString[i][0]));
      }

      if (polyPoints.length == ls.lineString.length) {
        setPolyLines();
      }
    } catch (e) {
      print(e);
    }
    double totalDistance = 0;
    totalDistance = calculateDistance(_initialPosition.latitude, _initialPosition.longitude,
        double.parse(appData.prtlat!), double.parse(appData.prtlon!));
    //print(totalDistance);
    setState(() {
      distance = totalDistance;
    });
  }

  setMarkers() {
    markers.add(
      Marker(
        markerId: const MarkerId("Start"),
        position: _initialPosition,
        infoWindow: const InfoWindow(
          title: "Start",
          snippet: "Current Loc",
        ),
      ),
    );

    markers.add(Marker(
      markerId: const MarkerId("Destination"),
      position: LatLng(double.parse(appData.prtlat!), double.parse(appData.prtlon!)),
      infoWindow: InfoWindow(
        title: appData.prtnm!,
        snippet: "Delv.Point",
      ),
    ));
    setState(() {});
  }

  setPolyLines() {
    Polyline polyline = Polyline(
      polylineId: const PolylineId("polyline"),
      color: Colors.green,
      points: polyPoints,
    );
    polyLines.add(polyline);
    setState(() {});
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setMarkers();
  }

  @override
  void initState() {
    _getUserLocation();
    getJsonData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Party Route'),
          backgroundColor: Colors.blue[600],
        ),
        body: Stack(children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 12,
            ),
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: false,
            rotateGesturesEnabled: true,
            zoomControlsEnabled: true,
            mapToolbarEnabled: true,
            mapType: MapType.normal,
            markers: markers,
            polylines: polyLines,
          ),
          Positioned(
              bottom: 50,
              left: 50,
              child: Container(
                  child: Card(
                child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Text("Distance: ${distance.toStringAsFixed(2)} Km",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              )))
        ]));
  }
}

//Create a new class to hold the Co-ordinates we've received from the response data
class LineString {
  LineString(this.lineString);
  List<dynamic> lineString;
}