import 'package:latlong/latlong.dart';

class Location {
  final String name;
  final LatLng latlng;
  final String imageURL;

  Location(this.name, this.latlng, this.imageURL);
}
