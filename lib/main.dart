import 'package:flutter/material.dart';
import 'package:relevart/bottom_navigation.dart';
import 'package:relevart/pages/travel_page.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => BottomNavigation(),
        '/travel_page': (context) => TravelPage(),
      },
    ));
