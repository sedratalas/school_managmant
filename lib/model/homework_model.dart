import 'package:meta/meta.dart';
import 'dart:convert';

class HomeworkModel {
  final String title;
  final String description;
  final DateTime dueDate;
  final int classId;
  final bool isHomework;
  final int id;

  HomeworkModel({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.classId,
    required this.isHomework,
    required this.id,
  });

  HomeworkModel copyWith({
    String? title,
    String? description,
    DateTime? dueDate,
    int? classId,
    bool? isHomework,
    int? id,
  }) =>
      HomeworkModel(
        title: title ?? this.title,
        description: description ?? this.description,
        dueDate: dueDate ?? this.dueDate,
        classId: classId ?? this.classId,
        isHomework: isHomework ?? this.isHomework,
        id: id ?? this.id,
      );

  factory HomeworkModel.fromRawJson(String str) => HomeworkModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HomeworkModel.fromJson(Map<String, dynamic> json) => HomeworkModel(
    title: json["title"],
    description: json["description"],
    dueDate: DateTime.parse(json["due_date"]),
    classId: json["class_id"],
    isHomework: json["is_homework"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "due_date": dueDate.toIso8601String(),
    "class_id": classId,
    "is_homework": isHomework,
    "id": id,
  };
}
