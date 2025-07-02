import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:school_managment/model/student_model.dart';
import 'package:school_managment/model/admin/user_model.dart';
import 'package:school_managment/service/admin/crud_service.dart';
import 'package:school_managment/screen/main_page/table_strategies/table_display_strategy.dart'; // استيراد الواجهة


class DataTableSection extends StatelessWidget {
  final List<dynamic> currentData;
  final bool isLoading;
  final String currentType;
  final Function(BuildContext context, String type) onAddPressed;
  final TableDisplayStrategy tableStrategy;

  const DataTableSection({
    super.key,
    required this.currentData,
    required this.isLoading,
    required this.currentType,
    required this.onAddPressed,
    required this.tableStrategy,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      color: const Color(0xffF3ECE6),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 850),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Data Table", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text("Add New"),
                  onPressed: () => onAddPressed(context, currentType),
                ),
              ],
            ),
            const SizedBox(height: 12),
            tableStrategy.buildTableHeader(),
            Expanded(
              child: isLoading
                  ? ListView.builder(
                itemCount: 6,
                itemBuilder: (_, __) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    child: Row(
                      children: List.generate(
                        5,
                            (_) => Expanded(
                          child: Container(
                            height: 20,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
                  : currentData.isEmpty
                  ? const Center(child: Text("No data available"))
                  : ListView.builder(
                itemCount: currentData.length,
                itemBuilder: (context, index) => tableStrategy.buildTableRow(currentData[index], context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
