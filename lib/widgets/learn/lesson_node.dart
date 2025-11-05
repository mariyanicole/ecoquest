import 'package:flutter/material.dart';
enum LessonStatus { completed, active, locked }
class LessonNode extends StatelessWidget {
  final dynamic lesson;
  final LessonStatus status;
  final bool isEven;
  final VoidCallback? onTap;
  const LessonNode({super.key, this.lesson, required this.status, required this.isEven, this.onTap});
  @override
  Widget build(BuildContext context) {
    Color nodeColor = Colors.grey.shade300;
    Color iconColor = Colors.grey.shade600;
    IconData icon = lesson.icon;
    if (status == LessonStatus.completed) {
      nodeColor = Colors.yellow.shade600;
      iconColor = Colors.white;
    } else if (status == LessonStatus.active) {
      nodeColor = const Color(0xFF58CC02);
      iconColor = Colors.white;
    }
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: nodeColor,
              border: Border.all(color: const Color(0xFF58CC02), width: 6),
            ),
            child: Icon(icon, color: iconColor, size: 40),
          ),
          const SizedBox(height: 8),
          Text(
            lesson.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
