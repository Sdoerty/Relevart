import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:relevart/pages/profile/profile.dart';
import 'package:relevart/pages/travel/travel_table.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}


class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    // Bottom navigation TravelTable
    TravelTable(),
    // Bottom navigation Profile
    Profile(),
    // Bottom navigation Notifications
    Text(
      'Index 2: Notifications',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: OutlinedButton.icon(
            onPressed: () => Navigator.of(context).pushNamed('/bottom_navigation/create_travel'),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white, width: 1),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
              ),
            ),
            icon: const Icon(
              Icons.assistant_navigation,
              color: Colors.white,
            ),
            label: const Text(
              'Начать путешествие',
              style: TextStyle(color: Colors.white, fontSize: 16),
            )),
        centerTitle: true,
/*          bottom: const TabBar(
            tabs: <Widget>[
              // Вкладка завершенных путешествий
              Tab(icon: Icon(Icons.coffee), text: 'Мои путешествия'),
              // Вкладка путешествий в процессе
              Tab(icon: Icon(Icons.swap_calls), text: 'В процессе'),
            ],
          ),*/
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueGrey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Уведомления',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
