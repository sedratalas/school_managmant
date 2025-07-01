import 'package:flutter/material.dart';

class DashboardSidebar extends StatelessWidget {
  const DashboardSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      color: const Color(0xFF90A38A),
      child: Column(
        children: const [
          SizedBox(height: 20),
          Icon(Icons.dashboard, color: Colors.white),
          SizedBox(height: 20),
          Icon(Icons.analytics, color: Colors.white),
          SizedBox(height: 20),
          Icon(Icons.inventory, color: Colors.white),
          SizedBox(height: 20),
          Icon(Icons.settings, color: Colors.white),
        ],
      ),
    );
  }
}
