import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_leaflet_map/providers/location_provider.dart';

import 'package:flutter_leaflet_map/api_keys.dart';
import 'package:flutter_leaflet_map/data/data.dart';

import 'package:latlong/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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

  SpeedDial _buildFab(BuildContext context, LocationProvider location) => SpeedDial(
        overlayOpacity: 0.0,
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            label: "Areas",
            child: Icon(Icons.radio_button_unchecked),
            backgroundColor: Colors.blue,
            labelStyle: Theme.of(context).textTheme.subtitle1,
            onTap: () => location.toggleAreaVisibility(),
          ),
          SpeedDialChild(
            label: "Routes",
            child: Icon(Icons.subdirectory_arrow_left),
            backgroundColor: Colors.green,
            labelStyle: Theme.of(context).textTheme.subtitle1,
            onTap: () => location.toggleRouteVisibility(),
          ),
          SpeedDialChild(
            label: "Hotels",
            child: Icon(Icons.hotel),
            backgroundColor: Colors.deepPurple,
            labelStyle: Theme.of(context).textTheme.subtitle1,
            onTap: () => location.toggleHotelVisibility(),
          ),
        ],
      );

  void _animateMapTo(LatLng destLocation) {
    final destZoom = 15.0;
    final _latTween =
        Tween<double>(begin: _mapController.center.latitude, end: destLocation.latitude);
    final _lngTween =
        Tween<double>(begin: _mapController.center.longitude, end: destLocation.longitude);
    final _zoomTween = Tween<double>(begin: _mapController.zoom, end: destZoom);

    AnimationController animController =
        AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    Animation<double> animation =
        CurvedAnimation(parent: animController, curve: Curves.fastOutSlowIn);

    animController.addListener(() {
      _mapController.move(LatLng(_latTween.evaluate(animation), _lngTween.evaluate(animation)),
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

    return Scaffold(
      floatingActionButton: _buildFab(context, location),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          zoom: 12.0,
          center: LatLng(
              location.currentLocation.latlng.latitude, location.currentLocation.latlng.longitude),
        ),
        layers: [
          TileLayerOptions(
            tileProvider: NetworkTileProvider(),
            keepBuffer: 8,
            tileSize: 512,
            zoomOffset: -1,
            urlTemplate:
                "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}@2x?access_token={accessToken}",
            additionalOptions: {
              'accessToken': MAPBOX_ACCESS_TOKEN,
              'id': 'mapbox/dark-v10',
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
              if (location.isHotelVisible)
                for (int i = 0; i < hotels.length; ++i)
                  Marker(
                    width: 64.0,
                    height: 64.0,
                    point: LatLng(hotels[i].latlng.latitude, hotels[i].latlng.longitude),
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
                  radius: 800,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
