import 'package:meta/meta.dart';
import 'dart:convert';

class ClassModel {
  final String name;
  final int teacherId;
  final int id;

  ClassModel({
    required this.name,
    required this.teacherId,
    required this.id,
  });

  ClassModel copyWith({
    String? name,
    int? teacherId,
    int? id,
  }) =>
      ClassModel(
        name: name ?? this.name,
        teacherId: teacherId ?? this.teacherId,
        id: id ?? this.id,
      );

  factory ClassModel.fromRawJson(String str) => ClassModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClassModel.fromJson(Map<String, dynamic> json) => ClassModel(
    name: json["name"],
    teacherId: json["teacher_id"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "teacher_id": teacherId,
    "id": id,
  };
}
