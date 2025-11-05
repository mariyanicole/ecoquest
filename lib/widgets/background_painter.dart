import 'package:flutter/material.dart';

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    // Bottom green shape
    paint.color = const Color(0xFF58CC02);
    final path = Path();
    path.moveTo(0, size.height * 0.65);
    path.quadraticBezierTo(size.width * 0.1, size.height * 0.8,
        size.width * 0.35, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.6, size.height * 0.7,
        size.width * 0.8, size.height * 0.8);
    path.quadraticBezierTo(
        size.width, size.height * 0.9, size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);

    // Left middle shape
    final paintLeft = Paint()
      ..color = const Color(0xFF58CC02).withAlpha((0.8 * 255).round())
      ..style = PaintingStyle.fill;
    final pathLeft = Path();
    pathLeft.moveTo(0, size.height * 0.3);
    pathLeft.quadraticBezierTo(
        size.width * 0.25, size.height * 0.35, 0, size.height * 0.5);
    pathLeft.close();
    canvas.drawPath(pathLeft, paintLeft);

    // Top right shape
    final paintTopRight = Paint()
      ..color = const Color(0xFF58CC02).withAlpha((0.8 * 255).round())
      ..style = PaintingStyle.fill;
    final pathTopRight = Path();
    pathTopRight.moveTo(size.width, 0);
    pathTopRight.quadraticBezierTo(
        size.width * 0.8, size.height * 0.05, size.width * 0.9, size.height * 0.2);
     pathTopRight.quadraticBezierTo(
        size.width, size.height * 0.25, size.width, size.height * 0.2);
    pathTopRight.lineTo(size.width, 0);
    pathTopRight.close();
    canvas.drawPath(pathTopRight, paintTopRight);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
