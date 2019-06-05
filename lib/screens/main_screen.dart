import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_leaflet_map/providers/location_provider.dart';
import 'package:flutter_leaflet_map/data/data.dart';

import 'package:flutter_leaflet_map/widgets/location_card.dart';
import 'package:flutter_leaflet_map/widgets/map_card.dart';

class MainScreen extends StatelessWidget {
  Widget _buildMap() => Flexible(
        flex: 4,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Card(
            elevation: 8.0,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: MapCard(),
          ),
        ),
      );

  Widget _budildMyPlaces(BuildContext context) => Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          "My Places",
          style: Theme.of(context).textTheme.title,
        ),
      );

  Widget _buildLocationCards(BuildContext context) => Flexible(
        flex: 1,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            LocationCard(0, locations[0]),
            LocationCard(1, locations[1]),
            LocationCard(2, locations[2]),
            LocationCard(3, locations[3]),
            LocationCard(4, locations[4]),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    final LocationProvider location = Provider.of<LocationProvider>(context);

    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  location.toggleHotelVisibility();
                },
                child: Text(
                  "Hotels",
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              FlatButton(
                onPressed: () {
                  location.toggleRouteVisibility();
                },
                child: Text(
                  "Routes",
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              FlatButton(
                onPressed: () {
                  location.toggleAreaVisibility();
                },
                child: Text(
                  "Areas",
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "Flutter Map",
          style: Theme.of(context).textTheme.title,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          _buildMap(),
          _budildMyPlaces(context),
          _buildLocationCards(context),
        ],
      ),
    );
  }
}
