import 'package:flutter/material.dart';
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
          style: Theme.of(context).textTheme.headline6,
        ),
      );

  Widget _buildLocationCards(BuildContext context) => Flexible(
        flex: 1,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            for (int i = 0; i < locations.length; ++i) LocationCard(i, locations[i]),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: Text(
          "Flutter Map",
          style: Theme.of(context).textTheme.headline6,
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
