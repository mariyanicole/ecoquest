import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecoquest/user_progress_provider.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProgressProvider>(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: theme.appBarTheme.titleTextStyle),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: theme.appBarTheme.elevation,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: theme.primaryColor.withAlpha((0.2 * 255).round()),
              child: Icon(Icons.person, size: 48, color: theme.primaryColor),
            ),
            const SizedBox(height: 16),
            Text('Eco Hero', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Level ${(user.xp / 100).floor() + 1}', style: theme.textTheme.bodyLarge),
            const SizedBox(height: 24),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStat(theme, 'XP', user.xp, Icons.star, Colors.yellow.shade600),
                    _buildStat(theme, 'Streak', user.streak, Icons.local_fire_department, Colors.orange.shade400),
                    _buildStat(theme, 'Lives', user.lives, Icons.favorite, Colors.red.shade400),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Badges', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _buildBadge(theme, 'Learner', Icons.school, theme.primaryColor),
                _buildBadge(theme, 'Recycler', Icons.recycling, Colors.green),
                _buildBadge(theme, 'Contributor', Icons.volunteer_activism, Colors.blue),
              ],
            ),
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Recent Activity', style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(Icons.check_circle, color: theme.primaryColor),
                title: Text('Completed lesson #${user.currentLesson}', style: theme.textTheme.bodyLarge),
                subtitle: Text('Earned 25 XP', style: theme.textTheme.bodyMedium),
              ),
            ),
            Card(
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(Icons.favorite, color: Colors.red.shade400),
                title: Text('Maintained streak', style: theme.textTheme.bodyLarge),
                subtitle: Text('Streak: ${user.streak}', style: theme.textTheme.bodyMedium),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(ThemeData theme, String label, int value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 6),
        Text(label, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        Text(value.toString(), style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildBadge(ThemeData theme, String label, IconData icon, Color color) {
    return Chip(
      avatar: Icon(icon, color: color, size: 20),
      label: Text(label, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
      backgroundColor: color.withAlpha((0.1 * 255).round()),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }
}
