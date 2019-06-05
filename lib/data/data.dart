import 'package:latlong/latlong.dart';

import 'package:flutter_leaflet_map/models/location.dart';

final List<Location> locations = [
  Location(
      "Balaju Park", LatLng(27.733774, 85.301682), "assets/images/loc1.jpg"),
  Location("Bus Park", LatLng(27.734628, 85.308154), "assets/images/loc2.jpg"),
  Location("Balaju", LatLng(27.726913, 85.304568), "assets/images/loc3.jpg"),
  Location(
      "Prime College", LatLng(27.717039, 85.302843), "assets/images/loc4.jpg"),
  Location("Swayambhu", LatLng(27.714793, 85.290570), "assets/images/loc5.jpg"),
];

final List<Location> hotels = [
  Location("Test1", LatLng(27.7774, 85.3082), "assets/images/loc1.jpg"),
  Location("Test2", LatLng(27.7628, 85.3054), "assets/images/loc2.jpg"),
  Location("Test3", LatLng(27.7913, 85.3068), "assets/images/loc3.jpg"),
  Location("Test4", LatLng(27.7039, 85.3043), "assets/images/loc4.jpg"),
  Location("Test5", LatLng(27.7793, 85.2970), "assets/images/loc5.jpg"),
];

final List<LatLng> routePts = [
  LatLng(27.714793, 85.290570),
  LatLng(27.733774, 85.301682),
  LatLng(27.734628, 85.308154),
  LatLng(27.726913, 85.304568),
  LatLng(27.717039, 85.302843),
];
