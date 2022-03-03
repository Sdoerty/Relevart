import 'package:flutter/material.dart';
import 'package:relevart/bottom_navigation.dart';
import 'package:relevart/pages/create_travel.dart';
import 'package:relevart/pages/travel_page.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => BottomNavigation(),
        '/travel_page': (context) => TravelPage(),
        '/create_travel': (context) => CreateTravel(),
      },
    ));
