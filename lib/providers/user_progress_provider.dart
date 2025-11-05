import 'package:flutter/foundation.dart';


class UserProgressProvider with ChangeNotifier {
  // Placeholder for user progress data
  int _xp = 0;
  int get xp => _xp;

  int _streak = 0;
  int get streak => _streak;

  final int _lives = 5;
  int get lives => _lives;


  final Set<int> _completedLessons = {};
  Set<int> get completedLessons => _completedLessons;

  int get currentLesson {
    // Return the next lesson id (mock logic: next after last completed)
    if (_completedLessons.isEmpty) return 0;
    return _completedLessons.reduce((a, b) => a > b ? a : b) + 1;
  }

  void completeLesson(int lessonId, [int xpEarned = 25]) {
    _completedLessons.add(lessonId);
    _xp += xpEarned;
    _streak++;
    // In a real app, you would save this progress
    // saveProgress();
    notifyListeners();
  }
  
  // In a real app, you would have methods to save and load progress
  // using shared_preferences
}
