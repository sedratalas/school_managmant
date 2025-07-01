import 'package:meta/meta.dart';
import 'dart:convert';

class CreateUserModel {
  final String username;
  final String phoneNumber;
  final String password;

  CreateUserModel({
    required this.username,
    required this.phoneNumber,
    required this.password,
  });

  CreateUserModel copyWith({
    String? username,
    String? phoneNumber,
    String? password,
  }) =>
      CreateUserModel(
        username: username ?? this.username,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        password: password ?? this.password,
      );

  factory CreateUserModel.fromRawJson(String str) => CreateUserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateUserModel.fromJson(Map<String, dynamic> json) => CreateUserModel(
    username: json["username"],
    phoneNumber: json["phone_number"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "phone_number": phoneNumber,
    "password": password,
  };
}
