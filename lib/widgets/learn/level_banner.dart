import 'package:flutter/material.dart';
class LevelBanner extends StatelessWidget {
  final dynamic levelData;
  const LevelBanner({super.key, this.levelData});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF84D821),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF4AAE02), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.1 * 255).round()),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        levelData.title,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
