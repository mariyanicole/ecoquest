import 'package:flutter/material.dart';
class QuizFeedbackFooter extends StatelessWidget {
  final bool isCorrect;
  final String explanation;
  final String correctAction;
  final VoidCallback onContinue;
  const QuizFeedbackFooter({
    super.key,
    required this.isCorrect,
    required this.explanation,
    required this.correctAction,
    required this.onContinue,
  });
  @override
  Widget build(BuildContext context) {
    return const Text('QuizFeedbackFooter');
  }
}
