import 'package:flutter/material.dart';
import 'package:school_managment/model/admin/user_model.dart';
import 'package:school_managment/screen/main_page/table_strategies/table_display_strategy.dart';

class UserTableStrategy implements TableDisplayStrategy {
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
          Expanded(flex: 2, child: Text("Username", style: headerTextStyle)),
          Expanded(flex: 2, child: Text("Phone", style: headerTextStyle)),
          Expanded(flex: 1, child: Text("Role", style: headerTextStyle)),
          Expanded(flex: 1, child: Text("Active", style: headerTextStyle)),
        ],
      ),
    );
  }

  @override
  Widget buildTableRow(dynamic item, BuildContext context) {
    final user = item as UserModel;
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
          Expanded(flex: 1, child: Text(user.id.toString(), style: cellTextStyle)),
          Expanded(flex: 2, child: Text(user.username, style: cellTextStyle)),
          Expanded(flex: 2, child: Text(user.phoneNumber, style: cellTextStyle)),
          Expanded(flex: 1, child: Text(user.role, style: cellTextStyle)),
          Expanded(flex: 1, child: Text(user.isActive ? "Yes" : "No", style: cellTextStyle)),
        ],
      ),
    );
  }
}
