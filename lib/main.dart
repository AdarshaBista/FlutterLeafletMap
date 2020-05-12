import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_leaflet_map/providers/location_provider.dart';

import 'package:flutter_leaflet_map/screens/main_screen.dart';

void main() => runApp(LeafletMap());

class LeafletMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LocationProvider>.value(
      notifier: LocationProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Map',
        theme: ThemeData(
          fontFamily: "TMS",
          primarySwatch: Colors.red,
          primaryIconTheme: IconThemeData(
            color: Colors.black,
          ),
          textTheme: TextTheme(
            headline6: TextStyle(
              color: Colors.black,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
            headline5: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontStyle: FontStyle.normal,
            ),
            subtitle1: TextStyle(
              color: Colors.grey,
              fontSize: 14.0,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        home: MainScreen(),
      ),
    );
  }
}
