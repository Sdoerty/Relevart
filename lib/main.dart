import 'package:flutter/material.dart';
import 'package:relevart/auth.dart';
import 'package:relevart/bottom_navigation.dart';
import 'package:relevart/pages/create_travel.dart';
import 'package:relevart/pages/settings.dart';
import 'package:relevart/pages/travel_page.dart';
import 'package:relevart/root_page.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => RootPage(auth: new Auth()),
        '/bottom_navigation': (context) => BottomNavigation(),
        '/bottom_navigation/travel_page': (context) => TravelPage(),
        '/bottom_navigation/create_travel': (context) => CreateTravel(),
        '/profile/settings': (context) => Settings(),
      },
    ));
