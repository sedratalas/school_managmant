import 'package:meta/meta.dart';
import 'dart:convert';

class UserModel {
  final String username;
  final String phoneNumber;
  final int id;
  final String role;
  final bool isActive;

  UserModel({
    required this.username,
    required this.phoneNumber,
    required this.id,
    required this.role,
    required this.isActive,
  });

  UserModel copyWith({
    String? username,
    String? phoneNumber,
    int? id,
    String? role,
    bool? isActive,
  }) =>
      UserModel(
        username: username ?? this.username,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        id: id ?? this.id,
        role: role ?? this.role,
        isActive: isActive ?? this.isActive,
      );

  factory UserModel.fromRawJson(String str) => UserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    username: json["username"],
    phoneNumber: json["phone_number"],
    id: json["id"],
    role: json["role"],
    isActive: json["is_active"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "phone_number": phoneNumber,
    "id": id,
    "role": role,
    "is_active": isActive,
  };
}
