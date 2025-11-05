import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/app_state.dart';
import '../models/ewaste_item.dart';
import '../widgets/quiz/quiz_feedback_footer.dart';

class QuizScreen extends StatefulWidget {
  final String lessonId;
  final int level;

  const QuizScreen({super.key, required this.lessonId, required this.level});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late List<EWasteItem> _questions;
  int _currentQuestionIndex = 0;
  bool _isAnswering = false;
  bool? _isCorrect;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }
  
  void _loadQuestions() {
      final levelQuestions = eWasteItems.where((item) => item.level == widget.level).toList();
      levelQuestions.shuffle();
      _questions = levelQuestions.take(5).toList();
  }

  EWasteItem get _currentQuestion => _questions[_currentQuestionIndex];

  void _handleAnswer(String selectedAction) {
    if (_isAnswering) return;

    setState(() {
      _isAnswering = true;
      _isCorrect = selectedAction == _currentQuestion.correctAction;
    });

    final appState = context.read<AppState>();
    if (_isCorrect!) {
      appState.incrementXp(10);
      appState.incrementStreak();
    } else {
      appState.resetStreak();
    }
  }

  void _proceedToNext() {
    if (_isCorrect!) {
      if (_currentQuestionIndex < _questions.length - 1) {
        setState(() {
          _currentQuestionIndex++;
          _isAnswering = false;
          _isCorrect = null;
        });
      } else {
        // Lesson complete
        context.read<AppState>().completeLesson(widget.lessonId);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lesson Complete! +50 XP'), backgroundColor: Colors.green),
        );
      }
    } else {
      // If incorrect, just end the lesson
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_currentQuestionIndex) / _questions.length;
    
    return Scaffold(
      backgroundColor: const Color(0xFFE0F2FE),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: ClipRRect(
                       borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey.shade300,
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF58CC02)),
                        minHeight: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Question Area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        _currentQuestion.image,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _currentQuestion.question,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF075985)),
                    ),
                    const SizedBox(height: 24),
                    _buildAnswerButton('reuse', 'Reuse'),
                    const SizedBox(height: 12),
                    _buildAnswerButton('recycle', 'Recycle'),
                    const SizedBox(height: 12),
                    _buildAnswerButton('dispose', 'Dispose'),
                  ],
                ),
              ),
            ),
            
            // Feedback Footer
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              transform: _isAnswering ? Matrix4.translationValues(0, 0, 0) : Matrix4.translationValues(0, 250, 0),
              child: QuizFeedbackFooter(
                isCorrect: _isCorrect ?? false,
                explanation: _currentQuestion.explanation,
                correctAction: _currentQuestion.correctAction,
                onContinue: _proceedToNext,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerButton(String action, String text) {
    Color borderColor = Colors.grey.shade300;
    
    if (_isAnswering) {
      if (action == _currentQuestion.correctAction) {
        borderColor = Colors.green;
      } else {
        borderColor = Colors.red;
      }
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isAnswering ? null : () => _handleAnswer(action),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: borderColor, width: 2),
          ),
          elevation: 2,
        ),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
    );
  }
}