import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../user_progress_provider.dart';
// ...existing code...
import 'dart:ui';

// --- Data Models ---

class Lesson {
  final int id;
  final String title;
  final IconData icon;
  Lesson({required this.id, required this.title, required this.icon});
}

class LevelData {
  final int level;
  final String title;
  final IconData icon;
  final List<Lesson> lessons;
  LevelData({required this.level, required this.title, required this.icon, required this.lessons});
}


class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data for the learning path
    final List<LevelData> learningPathData = [
       LevelData(level: 1, title: "Level 1: Home Electronics", icon: PhosphorIcons.house(PhosphorIconsStyle.fill), lessons: [
        Lesson(id: 0, title: "Daily Devices", icon: PhosphorIcons.deviceMobile(PhosphorIconsStyle.fill)),
        Lesson(id: 1, title: "Kitchen & Living", icon: PhosphorIcons.plugs(PhosphorIconsStyle.fill)),
      ]),
      LevelData(level: 2, title: "Level 2: Component Deep Dive", icon: PhosphorIcons.cpu(PhosphorIconsStyle.fill), lessons: [
        Lesson(id: 2, title: "Batteries & Cables", icon: PhosphorIcons.batteryChargingVertical(PhosphorIconsStyle.fill)),
        Lesson(id: 3, title: "Inside the Box", icon: PhosphorIcons.hardDrive(PhosphorIconsStyle.fill)),
      ]),
      LevelData(level: 3, title: "Level 3: Advanced Management", icon: PhosphorIcons.buildings(PhosphorIconsStyle.fill), lessons: [
        Lesson(id: 4, title: "Specialized Waste", icon: PhosphorIcons.factory(PhosphorIconsStyle.fill)),
        Lesson(id: 5, title: "Hazardous Materials", icon: PhosphorIcons.warning(PhosphorIconsStyle.fill)),
      ]),
      LevelData(level: 4, title: "Level 4: Industrial E-Waste", icon: PhosphorIcons.robot(PhosphorIconsStyle.fill), lessons: [
        Lesson(id: 6, title: "Heavy Machinery", icon: PhosphorIcons.gearSix(PhosphorIconsStyle.fill)),
        Lesson(id: 7, title: "Infrastructure", icon: PhosphorIcons.cellSignalHigh(PhosphorIconsStyle.fill)),
      ]),
      LevelData(level: 5, title: "Level 5: Global E-Waste Policy", icon: PhosphorIcons.globe(PhosphorIconsStyle.fill), lessons: [
        Lesson(id: 8, title: "Laws & Treaties", icon: PhosphorIcons.scales(PhosphorIconsStyle.fill)),
        Lesson(id: 9, title: "Circular Economy", icon: PhosphorIcons.recycle(PhosphorIconsStyle.fill)),
      ]),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          _buildHeader(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Stack(
                children: [
                  CustomPaint(
                      size: Size(MediaQuery.of(context).size.width - 32, (learningPathData.expand((l) => l.lessons).length + learningPathData.length) * 180.0),
                      painter: PathPainter(nodeCount: learningPathData.expand((l) => l.lessons).length + learningPathData.length),
                    ),
                  _buildLearningPath(context, learningPathData),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildHeader(BuildContext context) {
    final userProgress = Provider.of<UserProgressProvider>(context);
    final currentLevel = (userProgress.xp / 100).floor() + 1;
    final currentLevelXp = userProgress.xp % 100;
    final xpPercentage = currentLevelXp / 100.0;

    return SliverAppBar(
      backgroundColor: const Color(0xFF58CC02),
      pinned: true,
      elevation: 0,
      toolbarHeight: 120,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(PhosphorIcons.leaf(PhosphorIconsStyle.fill), color: Colors.white, size: 28),
                      const SizedBox(width: 8),
                      const Text(
                        "EcoQuest",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _buildStatIcon(PhosphorIcons.star(PhosphorIconsStyle.fill), Colors.yellow.shade300, userProgress.xp),
                      const SizedBox(width: 16),
                      _buildStatIcon(PhosphorIcons.fire(PhosphorIconsStyle.fill), Colors.orange.shade400, userProgress.streak),
                      const SizedBox(width: 16),
                      _buildStatIcon(PhosphorIcons.heart(PhosphorIconsStyle.fill), Colors.red.shade400, userProgress.lives),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Level $currentLevel', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                      Text('$currentLevelXp / 100 XP', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  LinearProgressIndicator(
                    value: xpPercentage,
                    backgroundColor: const Color.fromRGBO(255, 255, 255, 0.3),
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow.shade300),
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatIcon(IconData icon, Color color, int value) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 4),
        Text(
          value.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildLearningPath(BuildContext context, List<LevelData> pathData) {
    final userProgress = Provider.of<UserProgressProvider>(context);
    // Always start at Level 1's first lesson if no lesson is selected
    if (userProgress.currentLesson == -1) {
      userProgress.currentLesson = 0;
    }
    List<Widget> pathItems = [];
    int lessonCounter = 0;

    for (var level in pathData) {
      pathItems.add(_LevelTitleCard(title: level.title, icon: level.icon));
      lessonCounter++;

      for (var lesson in level.lessons) {
        bool isCompleted = userProgress.completedLessons.contains(lesson.id);
        bool isActive = userProgress.currentLesson == lesson.id;
        // Zig-zag: alternate left/right for each lesson across the whole path
        bool isLeft = (lessonCounter % 2 == 0);
        pathItems.add(
          _LessonNode(
            lesson: lesson,
            isCompleted: isCompleted,
            isActive: isActive,
            isLeftAligned: isLeft,
          ),
        );
        lessonCounter++;
      }
    }
    return Column(children: pathItems);
  }
}

// --- Custom Widgets for the Learning Path ---

class _LevelTitleCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const _LevelTitleCard({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 24),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF58CC02),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LessonNode extends StatelessWidget {
  final Lesson lesson;
  final bool isCompleted;
  final bool isActive;
  final bool isLeftAligned;

  const _LessonNode({
    required this.lesson,
    required this.isCompleted,
    required this.isActive,
    required this.isLeftAligned,
  });

  @override
  Widget build(BuildContext context) {
    // Make all nodes use the exact circular green style from the attachment.
    // Active nodes are slightly larger and have a stronger glow/border.
    final node = AnimatedContainer(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOut,
      width: isActive ? 96.0 : 74.0,
      height: isActive ? 96.0 : 74.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          colors: [Color(0xFF62E10B), Color(0xFF39C400)],
          center: Alignment(-0.2, -0.2),
          radius: 0.85,
        ),
        border: Border.all(color: const Color(0xFF215E00), width: isActive ? 6.0 : 4.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF39C400).withAlpha(isActive ? (0.22 * 255).round() : (0.14 * 255).round()),
            blurRadius: isActive ? 40.0 : 24.0,
            spreadRadius: isActive ? 18.0 : 8.0,
          ),
          BoxShadow(
            color: Colors.black.withAlpha((0.06 * 255).round()),
            blurRadius: isActive ? 8.0 : 6.0,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            lesson.icon,
            color: Colors.white,
            size: isActive ? 48.0 : 36.0,
          ),
          // small rounded white notch near the top to match the reference image
          Positioned(
            top: isActive ? 14.0 : 12.0,
            child: Container(
              width: isActive ? 38.0 : 32.0,
              height: isActive ? 8.0 : 7.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
          ),
        ],
      ),
    );

    Widget startButton() => Container(
      margin: const EdgeInsets.only(top: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [Color(0xFF39C400), Color(0xFF2EA000)]),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF2EA000), width: 1.5),
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha((0.18 * 255).round()), offset: const Offset(0, 6), blurRadius: 8),
            BoxShadow(color: Colors.white.withAlpha((0.04 * 255).round()), offset: const Offset(0, -2), blurRadius: 0),
          ],
        ),
        child: const SizedBox(
          height: 48,
          width: 140,
          child: Center(
            child: Text(
              'START',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 16,
                letterSpacing: 0.6,
              ),
            ),
          ),
        ),
      ),
    );

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: isLeftAligned ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isLeftAligned) const Spacer(),
          Column(
            children: [
              node,
              const SizedBox(height: 8),
              if (isActive)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withAlpha((0.06 * 255).round()), blurRadius: 8, offset: const Offset(0, 3)),
                    ],
                  ),
                  child: Text(
                    lesson.title,
                    style: const TextStyle(
                      color: Color(0xFF2A7B00),
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              else
                Text(
                  lesson.title,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              if (isActive) startButton(),
            ],
          ),
          if (isLeftAligned) const Spacer(),
        ],
      ),
    );
  }


}

// Custom Painter for the S-Curve Path

class PathPainter extends CustomPainter {
  final int nodeCount;
  PathPainter({required this.nodeCount});

  @override
  void paint(Canvas canvas, Size size) {
    // Draw a smooth S-like curved dashed path similar to the screenshot
    final paint = Paint()
      ..color = const Color(0xFFBFC7CC)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final double titleHeight = 80;
    final double nodeHeight = 120;
    double currentY = titleHeight;
    final double centerX = size.width / 2;
    final double offset = size.width / 4;

  // start the path just under the first level pill so it begins at Level 1
  final double startY = titleHeight - 20.0;
  path.moveTo(centerX, startY);

    int lessonIndex = 0;
    for (int i = 0; i < nodeCount; i++) {
      final bool isTitle = (i % 3 == 0);

      if (isTitle) {
        // straight down to title
        path.lineTo(centerX, currentY);
        currentY += 60;
      } else {
        final bool isLeft = lessonIndex % 2 == 0;
        final double endX = isLeft ? centerX - offset : centerX + offset;

  // stronger S-curve: outbound curve to node then return curve to center
  final double endY = currentY + nodeHeight;

  // make the outward curve more pronounced by moving control points nearer to ends
  final double controlX1 = centerX + (endX - centerX) * 0.08; // small horizontal move early
  final double controlY1 = currentY + nodeHeight * 0.15;
  final double controlX2 = centerX + (endX - centerX) * 0.92; // almost at the node x
  final double controlY2 = currentY + nodeHeight * 0.85;

  path.cubicTo(controlX1, controlY1, controlX2, controlY2, endX, endY);

  // return curve: flow back to center slightly below to form a smooth S
  final double returnY = endY + nodeHeight * 0.28;
  final double rControlX1 = endX + (centerX - endX) * 0.08;
  final double rControlY1 = endY + nodeHeight * 0.18;
  final double rControlX2 = endX + (centerX - endX) * 0.92;
  final double rControlY2 = returnY - nodeHeight * 0.08;
  path.cubicTo(rControlX1, rControlY1, rControlX2, rControlY2, centerX, returnY);

  currentY = returnY;
        lessonIndex++;
      }
    }

    // Short dashed pattern to match the look
    final dashArray = [8.0, 8.0];
    final dashedPath = dashPath(path, dashArray);
    canvas.drawPath(dashedPath, paint);
  }

  Path dashPath(Path source, List<double> dashArray) {
    final path = Path();
    final metric = source.computeMetrics();
    for (final PathMetric measure in metric) {
      double distance = 0.0;
      bool draw = true;
      while (distance < measure.length) {
        final length = draw ? dashArray[0] : dashArray[1];
        final double next = (distance + length).clamp(0.0, measure.length);
        if (draw) {
          path.addPath(measure.extractPath(distance, next), Offset.zero);
        }
        distance = next;
        draw = !draw;
        if (distance >= measure.length) break;
      }
    }
    return path;
  }

  @override
  bool shouldRepaint(covariant PathPainter oldDelegate) => oldDelegate.nodeCount != nodeCount;
}