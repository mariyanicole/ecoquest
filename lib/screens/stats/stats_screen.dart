import 'package:flutter/material.dart';
import 'package:ecoquest/ideas_screen.dart';

class StatsIdeasScreen extends StatelessWidget {
  const StatsIdeasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Stats & Ideas'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Stats'),
              Tab(text: 'Ideas'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text('Stats Screen - To be implemented')),
            IdeasScreen(),
          ],
        ),
      ),
    );
  }
}
