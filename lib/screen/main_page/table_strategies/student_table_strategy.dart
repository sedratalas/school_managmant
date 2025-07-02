import 'package:flutter/material.dart';
import 'package:school_managment/model/student_model.dart';
import 'package:school_managment/screen/main_page/table_strategies/table_display_strategy.dart';

class StudentTableStrategy implements TableDisplayStrategy {
  final num? editingStudentId;
  final String? editingField;
  final FocusNode editingFocusNode;
  final TextEditingController editingController;
  final Function(num studentId, String fieldName, String initialValue) onStartEditing;

  StudentTableStrategy({
    this.editingStudentId,
    this.editingField,
    required this.editingFocusNode,
    required this.editingController,
    required this.onStartEditing,
  });

  @override
  Widget buildTableHeader() {
    const headerTextStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Color(0xFF6B7280));
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

  @override
  Widget buildTableRow(dynamic item, BuildContext context) {
    final student = item as StudentModel;
    const cellTextStyle = TextStyle(fontSize: 13, color: Color(0xFF4B5563));
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200, width: 1.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text(student.id.toString(), style: cellTextStyle)),
          Expanded(flex: 2, child: Text(student.name, style: cellTextStyle)),
          Expanded(flex: 2, child: _buildEditableCell(student, 'class_id', student.classId.toString(), context)),
          Expanded(flex: 2, child: Text(student.parentId.toString(), style: cellTextStyle)),
          Expanded(flex: 1, child: _buildEditableCell(student, 'fees', student.fees.toString(), context)),
        ],
      ),
    );
  }
}
