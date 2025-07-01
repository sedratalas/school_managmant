import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:school_managment/model/student_model.dart';
import 'package:school_managment/model/admin/user_model.dart';
import 'package:school_managment/service/admin/crud_service.dart'; // لاستخدام UserRole

class DataTableSection extends StatelessWidget {
  final List<dynamic> currentData;
  final bool isLoading;
  final String currentType;
  final num? editingStudentId;
  final String? editingField;
  final FocusNode editingFocusNode;
  final TextEditingController editingController;
  final Function(num studentId, String fieldName, String initialValue) onStartEditing;
  final VoidCallback onSaveEditedValue;
  final Function(BuildContext context, String type) onAddPressed;

  const DataTableSection({
    super.key,
    required this.currentData,
    required this.isLoading,
    required this.currentType,
    this.editingStudentId,
    this.editingField,
    required this.editingFocusNode,
    required this.editingController,
    required this.onStartEditing,
    required this.onSaveEditedValue,
    required this.onAddPressed,
  });

  Widget _buildTableHeader() {
    const headerTextStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Color(0xFF6B7280));

    if (currentType == "student") {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Row(
          children: const [
            Expanded(flex: 1, child: Text("ID", style: headerTextStyle)),
            Expanded(flex: 2, child: Text("Name", style: headerTextStyle)),
            Expanded(flex: 2, child: Text("Class ID", style: headerTextStyle)),
            Expanded(flex: 2, child: Text("Parent ID", style: headerTextStyle)),
            Expanded(flex: 1, child: Text("Fees", style: headerTextStyle)),
          ],
        ),
      );
    } else if (["parent", "teacher", "busMentor"].contains(currentType)) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Row(
          children: const [
            Expanded(flex: 1, child: Text("ID", style: headerTextStyle)),
            Expanded(flex: 2, child: Text("Username", style: headerTextStyle)),
            Expanded(flex: 2, child: Text("Phone", style: headerTextStyle)),
            Expanded(flex: 1, child: Text("Role", style: headerTextStyle)),
            Expanded(flex: 1, child: Text("Active", style: headerTextStyle)),
          ],
        ),
      );
    } else {
      return const Center(child: Text("Select a category to display data."));
    }
  }

  Widget _buildEditableCell(StudentModel student, String fieldName, String value, BuildContext context) {
    bool isEditingThisCell = editingStudentId == student.id && editingField == fieldName;
    const cellTextStyle = TextStyle(fontSize: 13, color: Color(0xFF4B5563));

    return GestureDetector(
      onTap: () => onStartEditing(student.id, fieldName, value),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
        child: isEditingThisCell
            ? TextFormField(
          controller: editingController,
          focusNode: editingFocusNode,
          keyboardType: fieldName == 'fees' ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
            ),
          ),
          style: cellTextStyle,
          onFieldSubmitted: (newValue) {
            editingFocusNode.unfocus();
          },
        )
            : Text(value, style: cellTextStyle),
      ),
    );
  }

  Widget _buildTableRow(dynamic item, int index, BuildContext context) {
    Color rowColor = Colors.transparent;
    const cellTextStyle = TextStyle(fontSize: 13, color: Color(0xFF4B5563));
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: rowColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200!, width: 1.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text(item.id.toString(), style: cellTextStyle)),
          Expanded(flex: 2, child: Text(item is StudentModel ? item.name : item.username, style: cellTextStyle)),
          if (item is StudentModel) ...[
            Expanded(flex: 2, child: _buildEditableCell(item, 'class_id', item.classId.toString(), context)),
            Expanded(flex: 2, child: Text(item.parentId.toString(), style: cellTextStyle)),
            Expanded(flex: 1, child: _buildEditableCell(item, 'fees', item.fees.toString(), context)),
          ] else if (item is UserModel) ...[
            Expanded(flex: 2, child: Text(item.phoneNumber, style: cellTextStyle)),
            Expanded(flex: 1, child: Text(item.role, style: cellTextStyle)),
            Expanded(flex: 1, child: Text(item.isActive ? "Yes" : "No", style: cellTextStyle)),
          ] else ...[
            const SizedBox.shrink(),
          ]
        ],
      ),
    );
  }

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
            _buildTableHeader(),
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
                itemBuilder: (context, index) => _buildTableRow(currentData[index], index, context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
