import 'package:flutter/material.dart';

class UserProgressProvider with ChangeNotifier {
  int _xp = 0;
  int _streak = 0;
  int _lives = 5;
  int _currentLesson = 0;
  final Set<int> _completedLessons = {};

  int get xp => _xp;
  int get streak => _streak;
  int get lives => _lives;
  int get currentLesson => _currentLesson;
  set currentLesson(int value) {
    _currentLesson = value;
    notifyListeners();
  }
  Set<int> get completedLessons => _completedLessons;

  void completeLesson(int lessonId, int xpGained) {
    _completedLessons.add(lessonId);
    _xp += xpGained;
    _streak++;
    _currentLesson++;
    notifyListeners();
  }

  void answerIncorrectly() {
    if (_lives > 0) {
      _lives--;
      _streak = 0;
      notifyListeners();
    }
  }

  void addFavoriteIdea() {
    // Logic for adding ideas and checking for badges
    notifyListeners();
  }

  void logContribution() {
     // Logic for logging contributions and checking for badges
    _xp += 25;
    notifyListeners();
  }
}
