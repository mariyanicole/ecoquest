import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  int xp = 0;
  int streak = 0;
  List<String> completedLessons = [];

  void incrementXp(int value) {
    xp += value;
    notifyListeners();
  }

  void incrementStreak() {
    streak += 1;
    notifyListeners();
  }

  void resetStreak() {
    streak = 0;
    notifyListeners();
  }

  void completeLesson(String lessonId) {
    if (!completedLessons.contains(lessonId)) {
      completedLessons.add(lessonId);
      notifyListeners();
    }
  }
}
