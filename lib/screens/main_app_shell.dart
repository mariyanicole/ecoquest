import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:ecoquest/screens/learn/learn_screen.dart';
import 'package:ecoquest/ideas_screen.dart';
import 'package:ecoquest/hub_screen.dart';
import 'package:ecoquest/profile_screen.dart';

class MainAppShell extends StatefulWidget {
  const MainAppShell({super.key});

  @override
  State<MainAppShell> createState() => _MainAppShellState();
}

class _MainAppShellState extends State<MainAppShell> {
  int _selectedIndex = 0;


  Widget _buildTab(int index) {
    switch (index) {
      case 0:
        return const LearnScreen();
      case 1:
        return const IdeasScreen();
      case 2:
        return const HubScreen();
      case 3:
        return const ProfileScreen();
      default:
        return const LearnScreen();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildTab(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.gameController()),
            activeIcon: Icon(PhosphorIcons.gameController()),
            label: 'Learn',
          ),
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.chartBar()),
            activeIcon: Icon(PhosphorIcons.chartBar()),
            label: 'Ideas',
          ),
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.mapPin()),
            activeIcon: Icon(PhosphorIcons.mapPin()),
            label: 'Hub',
          ),
          BottomNavigationBarItem(
            icon: Icon(PhosphorIcons.user()),
            activeIcon: Icon(PhosphorIcons.user()),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
