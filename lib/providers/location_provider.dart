import 'package:flutter/material.dart';
import 'package:flutter_leaflet_map/models/location.dart';
import 'package:flutter_leaflet_map/data/data.dart';

class LocationProvider extends ChangeNotifier {
  Location _currentLocation = locations[0];
  bool hasCurrentLocationChanged = false;

  bool isHotelVisible = true;
  bool isRouteVisible = true;
  bool isAreaVisible = true;

  Location get currentLocation => _currentLocation;
  set currentLocation(Location loc) {
    _currentLocation = loc;
    hasCurrentLocationChanged = true;
    notifyListeners();
  }

  void toggleHotelVisibility() {
    isHotelVisible = !isHotelVisible;
    notifyListeners();
  }

  void toggleRouteVisibility() {
    isRouteVisible = !isRouteVisible;
    notifyListeners();
  }

  void toggleAreaVisibility() {
    isAreaVisible = !isAreaVisible;
    notifyListeners();
  }
}
