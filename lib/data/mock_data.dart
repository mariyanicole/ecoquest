import 'package:flutter/material.dart';

class LessonData {
	final int id;
	final String title;
	final IconData icon;
	LessonData({required this.id, required this.title, required this.icon});
}

class LevelData {
	final int level;
	final String title;
	final List<LessonData> lessons;
	LevelData({required this.level, required this.title, required this.lessons});
}

final List<LevelData> learningPathData = [
	LevelData(
		level: 1,
		title: "Level 1: Home Electronics",
		lessons: [
			LessonData(id: 0, title: "Daily Devices", icon: Icons.phone_android),
			LessonData(id: 1, title: "Kitchen & Living", icon: Icons.kitchen),
		],
	),
	LevelData(
		level: 2,
		title: "Level 2: Component Deep Dive",
		lessons: [
			LessonData(id: 2, title: "Power & Batteries", icon: Icons.battery_charging_full),
			LessonData(id: 3, title: "Cables & Boards", icon: Icons.cable),
		],
	),
];
