import 'package:dio/dio.dart';
import 'package:school_managment/model/admin/create_user_model.dart';

import '../../model/admin/user_model.dart';

enum UserRole {
  parent,
  teacher,
  busMentor,
}

String roleToEndpoint(UserRole role) {
  switch (role) {
    case UserRole.parent:
      return 'parents';
    case UserRole.teacher:
      return 'teachers';
    case UserRole.busMentor:
      return 'bus-mentors';
  }
}

String roleToCreationEndpoint(UserRole role) {
  switch (role) {
    case UserRole.parent:
      return 'parent';
    case UserRole.teacher:
      return 'teacher';
    case UserRole.busMentor:
      return 'bus-mentor';
  }
}

class CrudService {
  CrudService({required this.dio});

  Dio dio;
  late Response response;

  final String baseURL = "https://school-managment-app-tqbh.onrender.com/admin/users/";

  Future<List<UserModel>> getUsersByRole(UserRole role) async {
    try {
      String endpoint = roleToEndpoint(role);
      response = await dio.get(baseURL + endpoint);
      List<UserModel> users = [];
      for (var i = 0; i < response.data.length; i++) {
        users.add(UserModel.fromJson(response.data[i]));
      }
      return users;
    } catch (e) {
      print("Error fetching users with role $role: $e");
      return [];
    }
  }

  Future<bool> createUserByRole(CreateUserModel user, UserRole role) async {
    try {
      String creationEndpoint = roleToCreationEndpoint(role);
      response = await dio.post(baseURL + creationEndpoint, data: user.toJson());
      return true;
    } catch (e) {
      print("Error creating user with role $role: $e");
      return false;
    }
  }
}
