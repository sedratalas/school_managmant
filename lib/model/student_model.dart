import 'package:meta/meta.dart';
import 'dart:convert';

class StudentModel {
  final String name;
  final num classId;
  final num parentId;
  final String profilePicture;
  final num fees;
  final num id;

  StudentModel({
    required this.name,
    required this.classId,
    required this.parentId,
    required this.profilePicture,
    required this.fees,
    required this.id,
  });

  StudentModel copyWith({
    String? name,
    num? classId,
    num? parentId,
    String? profilePicture,
    num? fees,
    num? id,
  }) =>
      StudentModel(
        name: name ?? this.name,
        classId: classId ?? this.classId,
        parentId: parentId ?? this.parentId,
        profilePicture: profilePicture ?? this.profilePicture,
        fees: fees ?? this.fees,
        id: id ?? this.id,
      );

  factory StudentModel.fromRawJson(String str) => StudentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    name: json["name"],
    classId: json["class_id"],
    parentId: json["parent_id"],
    profilePicture: json["profile_picture"],
    fees: json["fees"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "class_id": classId,
    "parent_id": parentId,
    "profile_picture": profilePicture,
    "fees": fees,
    "id": id,
  };
}
