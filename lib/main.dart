import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:relevart/bottom_navigation.dart';
import 'package:relevart/pages/travel/create_travel.dart';
import 'package:relevart/pages/profile/settings.dart';
import 'package:relevart/pages/travel/travel_page.dart';
import 'package:relevart/sign_in.dart';
import 'package:relevart/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: '/welcome_page',
    routes: {
      '/welcome_page': (context) => WelcomePage(),
      '/welcome_page/sign_in': (context) => SignIn(),
      '/bottom_navigation': (context) => BottomNavigation(),
      '/bottom_navigation/create_travel': (context) => CreateTravel(),
      '/profile/settings': (context) => Settings(),
      // '/bottom_navigation/travel_page': (context) => TravelPage(travel: null,)
    },
  ));
}
