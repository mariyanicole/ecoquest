import 'package:flutter/material.dart';
class PathConnector extends StatelessWidget {
  const PathConnector({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.grey.shade400,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }
}
