import 'package:meta/meta.dart';
import 'dart:convert';

class CommentModel {
  final int studentId;
  final String content;
  final int id;
  final int teacherId;
  final DateTime createdAt;
  final bool isRead;

  CommentModel({
    required this.studentId,
    required this.content,
    required this.id,
    required this.teacherId,
    required this.createdAt,
    required this.isRead,
  });

  CommentModel copyWith({
    int? studentId,
    String? content,
    int? id,
    int? teacherId,
    DateTime? createdAt,
    bool? isRead,
  }) =>
      CommentModel(
        studentId: studentId ?? this.studentId,
        content: content ?? this.content,
        id: id ?? this.id,
        teacherId: teacherId ?? this.teacherId,
        createdAt: createdAt ?? this.createdAt,
        isRead: isRead ?? this.isRead,
      );

  factory CommentModel.fromRawJson(String str) => CommentModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    studentId: json["student_id"],
    content: json["content"],
    id: json["id"],
    teacherId: json["teacher_id"],
    createdAt: DateTime.parse(json["created_at"]),
    isRead: json["is_read"],
  );

  Map<String, dynamic> toJson() => {
    "student_id": studentId,
    "content": content,
    "id": id,
    "teacher_id": teacherId,
    "created_at": createdAt.toIso8601String(),
    "is_read": isRead,
  };
}
