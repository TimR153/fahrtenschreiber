import 'package:fahrtenschreiber/views/profil_page.dart';
import 'package:fahrtenschreiber/views/statistik_page.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'fahrten_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomePage(),
      const FahrtenPage(),
      const StatistikPage(),
      const ProfilPage(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (idx) => setState(() => _selectedIndex = idx),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            selectedIcon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.directions_car),
            label: 'Fahrten',
          ),
          NavigationDestination(
            icon: Icon(Icons.stacked_bar_chart),
            label: 'Statistik',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
