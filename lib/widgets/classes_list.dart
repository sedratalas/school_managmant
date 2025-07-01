import 'package:flutter/material.dart';
import 'package:school_managment/model/classes_model.dart';

class ClassesListSection extends StatelessWidget {
  final List<ClassModel> classesData;
  final bool classesLoading;
  final VoidCallback onAddClassPressed;

  const ClassesListSection({
    super.key,
    required this.classesData,
    required this.classesLoading,
    required this.onAddClassPressed,
  });

  Widget _buildClassListItem(ClassModel classItem, Color iconColor) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.school, color: iconColor, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  classItem.name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  'Teacher ID: ${classItem.teacherId}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Text(
            classItem.id.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35.0, right: 20),
      child: Container(
        width: 300,
        height: 600,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xffF3ECE6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Classes List",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xffAC8685),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).primaryColor.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add, color: Colors.white, size: 20),
                      onPressed: onAddClassPressed,
                      padding: EdgeInsets.zero,
                      splashRadius: 20,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: classesLoading
                  ? const Center(child: CircularProgressIndicator())
                  : classesData.isEmpty
                  ? const Center(child: Text("No classes available."))
                  : ListView.builder(
                itemCount: classesData.length,
                itemBuilder: (context, index) {
                  List<Color> iconColors = [
                    const Color(0xFF6A5ACD),
                    const Color(0xFFF08080),
                    const Color(0xFF90EE90),
                    const Color(0xFFFFA500),
                    const Color(0xFF87CEEB),
                  ];
                  Color currentColor = iconColors[index % iconColors.length];
                  return _buildClassListItem(classesData[index], currentColor);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
