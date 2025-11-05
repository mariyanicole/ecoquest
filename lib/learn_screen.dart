import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:ecoquest/providers/user_progress_provider.dart';

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
         Lesson(id: 2, title: "Power & Batteries", icon: PhosphorIcons.batteryChargingVertical(PhosphorIconsStyle.fill)),
         Lesson(id: 3, title: "Cables & Boards", icon: PhosphorIcons.circuitry(PhosphorIconsStyle.fill)),
       ]),
       LevelData(level: 3, title: "Level 3: Advanced Management", icon: PhosphorIcons.buildings(PhosphorIconsStyle.fill), lessons: [
         Lesson(id: 4, title: "Specialized Waste", icon: PhosphorIcons.factory(PhosphorIconsStyle.fill)),
         Lesson(id: 5, title: "Medical & Lab", icon: PhosphorIcons.firstAidKit(PhosphorIconsStyle.fill)),
       ]),
        LevelData(level: 4, title: "Level 4: Industrial E-Waste", icon: PhosphorIcons.robot(PhosphorIconsStyle.fill), lessons: [
         Lesson(id: 6, title: "Data Centers", icon: PhosphorIcons.database(PhosphorIconsStyle.fill)),
     Lesson(id: 7, title: "Energy Sector", icon: PhosphorIcons.batteryChargingVertical(PhosphorIconsStyle.fill)),
       ]),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          _buildHeader(context),
          SliverToBoxAdapter(
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(MediaQuery.of(context).size.width, 1400),
                  painter: PathPainter(nodeCount: learningPathData.expand((l) => l.lessons).length + learningPathData.length),
                ),
                _buildLearningPath(context, learningPathData),
              ],
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
      toolbarHeight: 110,
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
    List<Widget> pathItems = [];
    int lessonCounter = 0;

    for (var level in pathData) {
      pathItems.add(_LevelTitleCard(title: level.title, icon: level.icon));
      lessonCounter++;
      
      for (var lesson in level.lessons) {
        bool isCompleted = userProgress.completedLessons.contains(lesson.id);
        bool isActive = userProgress.currentLesson == lesson.id;
        pathItems.add(
          _LessonNode(
            lesson: lesson,
            isCompleted: isCompleted,
            isActive: isActive,
            isLeftAligned: (lessonCounter % 4) < 2,
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF84D821),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF4AAE02), width: 2),
        boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha((0.2 * 255).round()),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Row(
        mainAxisAlignment: isLeftAligned ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          if (!isLeftAligned) const Spacer(flex: 3),
          _buildNode(context),
          const Spacer(flex: 2),
          if (isLeftAligned) const Spacer(flex: 3),
        ],
      ),
    );
  }

  Widget _buildNode(BuildContext context) {
    Color nodeColor = const Color(0xFFE5E7EB);
    Color iconColor = const Color(0xFF9CA3AF);
    IconData icon = PhosphorIcons.lock(PhosphorIconsStyle.fill);

    if (isCompleted) {
      nodeColor = Colors.yellow.shade600;
      iconColor = Colors.white;
      icon = PhosphorIcons.check(PhosphorIconsStyle.bold);
    } else if (isActive) {
      nodeColor = const Color(0xFF58CC02);
      iconColor = Colors.white;
      icon = lesson.icon;
    }

    return Column(
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
        if (isActive)
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: ElevatedButton(
              onPressed: () {
                Provider.of<UserProgressProvider>(context, listen: false).completeLesson(lesson.id);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF84D821),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                elevation: 4,
              ),
              child: const Text(
                "START",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}

// Custom Painter for the S-Curve Path

class PathPainter extends CustomPainter {
  final int nodeCount;
  PathPainter({required this.nodeCount});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFA3E635) // Changed this line for a more vibrant, theme-connected color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final path = Path();
    double titleHeight = 96;
    double nodeHeight = 160; 
    double currentY = titleHeight + (nodeHeight / 2) - 40;
    double centerX = size.width / 2;
    double offset = size.width / 4;
    
    path.moveTo(centerX, 0);

    int lessonIndex = 0;
    for (int i=0; i<nodeCount; i++){
        bool isTitle = (i % 3 == 0);
        
        if(isTitle){
            path.lineTo(centerX, currentY);
            currentY += 60;
        } else {
             bool isLeft = (lessonIndex % 4) < 2;
             final endX = isLeft ? centerX - offset : centerX + offset;
             
             final controlX1 = centerX;
             final controlY1 = currentY + nodeHeight * 0.4;
             final controlX2 = endX;
             final controlY2 = currentY + nodeHeight * 0.6;
             
             path.cubicTo(controlX1, controlY1, controlX2, controlY2, endX, currentY + nodeHeight);
             currentY += nodeHeight;
             lessonIndex++;
        }
    }

    final dashArray = [8.0, 6.0];
    final dashedPath = dashPath(path, dashArray);
    canvas.drawPath(dashedPath, paint);
  }

  Path dashPath(Path source, List<double> dashArray) {
    final path = Path();
    final metric = source.computeMetrics();
    double distance = 0.0;
    bool draw = true;
    for (final PathMetric measure in metric) {
        while (distance < measure.length) {
            final length = draw ? dashArray[0] : dashArray[1];
            if (distance + length > measure.length) {
                if (draw) {
                    path.addPath(measure.extractPath(distance, measure.length), Offset.zero);
                }
                break;
            }
            if (draw) {
                path.addPath(measure.extractPath(distance, distance + length), Offset.zero);
            }
            distance += length;
            draw = !draw;
        }
    }
    return path;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}