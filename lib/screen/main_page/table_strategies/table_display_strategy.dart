import 'package:flutter/material.dart';

abstract class TableDisplayStrategy {
  Widget buildTableHeader();
  Widget buildTableRow(dynamic item, BuildContext context);
}
