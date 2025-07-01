import 'package:meta/meta.dart';
import 'dart:convert';

class AttendanceModel {
  final int studentId;
  final bool isPresent;
  final int id;
  final DateTime date;

  AttendanceModel({
    required this.studentId,
    required this.isPresent,
    required this.id,
    required this.date,
  });

  AttendanceModel copyWith({
    int? studentId,
    bool? isPresent,
    int? id,
    DateTime? date,
  }) =>
      AttendanceModel(
        studentId: studentId ?? this.studentId,
        isPresent: isPresent ?? this.isPresent,
        id: id ?? this.id,
        date: date ?? this.date,
      );

  factory AttendanceModel.fromRawJson(String str) => AttendanceModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AttendanceModel.fromJson(Map<String, dynamic> json) => AttendanceModel(
    studentId: json["student_id"],
    isPresent: json["is_present"],
    id: json["id"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "student_id": studentId,
    "is_present": isPresent,
    "id": id,
    "date": date.toIso8601String(),
  };
}
