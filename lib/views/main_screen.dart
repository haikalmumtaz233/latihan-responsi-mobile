import 'package:flutter/material.dart';
import 'package:latihan_responsi_plug_e/db/shared_preferences.dart';
import 'package:latihan_responsi_plug_e/views/categories_page.dart';
import 'package:latihan_responsi_plug_e/views/favorite_page.dart';
import 'package:latihan_responsi_plug_e/views/profile_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    DBHelper().setPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget body() {
      switch (_currentIndex) {
        case 0:
          return const CategoriesPage();
        case 1:
          return const FavoritePage();
        case 2:
          return const ProfilePage();
        default:
          return const CategoriesPage();
      }
    }

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.brown[800],
        backgroundColor: Colors.white,
        elevation: 20,
        iconSize: 32,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            activeIcon: Icon(Icons.person_2),
            label: 'Profile',
          ),
        ],
      ),
      body: body(),
    );
  }
}
