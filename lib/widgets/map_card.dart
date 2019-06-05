import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter_leaflet_map/providers/location_provider.dart';
import 'package:flutter_leaflet_map/data/data.dart';

class MapCard extends StatefulWidget {
  @override
  MapCardState createState() {
    return MapCardState();
  }
}

class MapCardState extends State<MapCard> with TickerProviderStateMixin {
  MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  void _animateMapTo(LatLng destLocation) {
    final destZoom = 15.0;
    final _latTween = Tween<double>(
        begin: _mapController.center.latitude, end: destLocation.latitude);
    final _lngTween = Tween<double>(
        begin: _mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: _mapController.zoom, end: destZoom);

    AnimationController animController = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    Animation<double> animation =
        CurvedAnimation(parent: animController, curve: Curves.fastOutSlowIn);

    animController.addListener(() {
      _mapController.move(
          LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
          _zoomTween.evaluate(animation));
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animController.dispose();
      } else if (status == AnimationStatus.dismissed) {
        animController.dispose();
      }
    });
    animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final LocationProvider location = Provider.of<LocationProvider>(context);

    if (location.hasCurrentLocationChanged) {
      _animateMapTo(location.currentLocation.latlng);
      location.hasCurrentLocationChanged = false;
    }

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        zoom: 12.0,
        center: LatLng(location.currentLocation.latlng.latitude,
            location.currentLocation.latlng.longitude),
      ),
      layers: [
        TileLayerOptions(
          keepBuffer: 8,
          urlTemplate: "https://api.tiles.mapbox.com/v4/"
              "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
          additionalOptions: {
            'accessToken':
                'pk.eyJ1IjoiYWRyc2h6ZXJvIiwiYSI6ImNqdzJjZ3J6eDAxbW80Ym93cXUyenVkM2EifQ.6HRuGgAgE_by5ikDiv7aOw',
            'id': 'mapbox.dark',
          },
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 64.0,
              height: 64.0,
              point: LatLng(location.currentLocation.latlng.latitude,
                  location.currentLocation.latlng.longitude),
              builder: (BuildContext context) => Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
            ),
          ],
        ),
        if (location.isHotelVisible)
          for (int i = 0; i < hotels.length; ++i)
            MarkerLayerOptions(
              markers: [
                Marker(
                  width: 64.0,
                  height: 64.0,
                  point: LatLng(
                      hotels[i].latlng.latitude, hotels[i].latlng.longitude),
                  builder: (BuildContext context) => Icon(
                        Icons.hotel,
                        color: Colors.white,
                      ),
                ),
              ],
            ),
        if (location.isRouteVisible)
          PolylineLayerOptions(
            polylines: [
              Polyline(
                points: routePts,
                strokeWidth: 2.0,
                color: Colors.purple,
              ),
            ],
          ),
        if (location.isAreaVisible)
          CircleLayerOptions(
            circles: [
              CircleMarker(
                point: locations[0].latlng,
                color: Colors.blue.withOpacity(0.7),
                useRadiusInMeter: true,
                radius: 800, // 2000 meters | 2 km
              ),
            ],
          ),
      ],
    );
  }
}
