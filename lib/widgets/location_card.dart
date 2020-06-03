import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:flutter_leaflet_map/providers/location_provider.dart';

import 'package:flutter_leaflet_map/data/data.dart';
import 'package:flutter_leaflet_map/models/location.dart';

class LocationCard extends StatelessWidget {
  final Location _location;
  final int _index;

  const LocationCard(this._index, this._location);

  @override
  Widget build(BuildContext context) {
    final LocationProvider location = Provider.of<LocationProvider>(context);

    return InkWell(
      onTap: () {
        location.currentLocation = locations[_index];
      },
      child: Container(
        width: 200.0,
        margin: EdgeInsets.all(12.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Color(0xFF212121),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 32.0,
              backgroundImage: AssetImage(_location.imageURL),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _location.name,
                      style: Theme.of(context).textTheme.headline5,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "Lat: ${_location.latlng.latitude}",
                      style: Theme.of(context).textTheme.subtitle1,
                      overflow: TextOverflow.clip,
                    ),
                    Text(
                      "Lng: ${_location.latlng.longitude}",
                      style: Theme.of(context).textTheme.subtitle1,
                      overflow: TextOverflow.clip,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
