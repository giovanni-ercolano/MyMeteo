import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:MyMeteo/pages/Preferite_page.dart';
import 'package:MyMeteo/pages/profilePage.dart';
import 'package:MyMeteo/pages/weather.dart';

import 'pages/appbar.dart';


//db518e808bfe7200a4e13efd59891f54
class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    WeatherPage(),
    PreferitePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(),
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
          Positioned(
            left: 16,
            bottom: 8,
            right: 16,
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(24)),
                color: Colors.black,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: GNav(
                  backgroundColor: Colors.black,
                  color: Colors.white,
                  activeColor: Colors.white,
                  tabBackgroundColor: Colors.grey.shade800.withOpacity(0.50),
                  padding: const EdgeInsets.all(8),
                  gap: 8,
                  tabs: const [
                    GButton(icon: Icons.home, text: 'Home'),
                    GButton(
                      icon: Icons.favorite,
                      text: 'Preferiti',
                    ),
                    GButton(
                      icon: Icons.account_circle_rounded,
                      text: 'Profile',
                    ),
                  ],
                  selectedIndex: _selectedIndex,
                  onTabChange: (index) => setState(() {
                    _selectedIndex = index;
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}