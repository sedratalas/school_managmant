// import 'package:dio/dio.dart';
//
// import '../model/login_model.dart';
//
// class AuthService {
//   AuthService({required this.dio});
//
//   Dio dio;
//   late Response response;
//   String baseUrl = "https://school-managment-app-tqbh.onrender.com/admin/auth/login";
//
//   Future<String?> logIn(LoginModel user) async {
//     try {
//       response = await dio.post(baseUrl,
//           //queryParameters: user.toMap()
//         data: user.toMap(),
//       );
//       print(response);
//       return null;
//     } on DioException catch (e) {
//       if (e.response != null && e.response!.data is Map<String, dynamic>) {
//         if (e.response!.data.containsKey('detail')) {
//           return e.response!.data['detail']?.toString() ??
//               "Login failed: No details provided.";
//         }
//         if (e.response!.data.containsKey('message')) {
//           return e.response!.data['message']?.toString() ??
//               "Login failed: No details provided.";
//         }
//         if (e.response!.data.containsKey('error')) {
//           return e.response!.data['error']?.toString() ??
//               "Login failed: No details provided.";
//         }
//       }
//       return "An unknown login error occurred. Status: ${e.response
//           ?.statusCode}";
//     }
//   }
//
// }
import 'package:dio/dio.dart';

import '../model/login_model.dart';
import '../model/token_model.dart';

class AuthService {
  AuthService({required this.dio});

  final Dio dio;

  final String loginUrl = "https://school-managment-app-tqbh.onrender.com/admin/auth/login";
  final String refreshUrl = "https://school-managment-app-tqbh.onrender.com/admin/auth/refresh";

  Future<TokenModel> logIn(LoginModel user) async {
    try {
      final response = await dio.post(loginUrl,
          data: user.toMap()
      );

      // تحقق إن الاستجابة تحتوي على التوكنز
      if (response.statusCode == 200) {
        return TokenModel.fromJson(response.data);
      } else {
        throw Exception("Login failed with status: ${response.statusCode}");
      }

    } on DioException catch (e) {
      // محاولة قراءة الخطأ بشكل منظم
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        final data = e.response!.data as Map<String, dynamic>;
        if (data.containsKey('detail')) {
          throw Exception(data['detail'].toString());
        }
        if (data.containsKey('message')) {
          throw Exception(data['message'].toString());
        }
        if (data.containsKey('error')) {
          throw Exception(data['error'].toString());
        }
      }
      throw Exception("An unknown login error occurred. Status: ${e.response?.statusCode}");
    }
  }


  Future<TokenModel> refreshToken(String refreshToken) async {
    try {
      final response = await dio.post(refreshUrl, data: {
        'refresh_token': refreshToken,
      });

      if (response.statusCode == 200) {
        return TokenModel.fromJson(response.data);
      } else {
        throw Exception("Refresh token failed with status: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        final data = e.response!.data as Map<String, dynamic>;
        if (data.containsKey('detail')) {
          throw Exception(data['detail'].toString());
        }
        if (data.containsKey('message')) {
          throw Exception(data['message'].toString());
        }
        if (data.containsKey('error')) {
          throw Exception(data['error'].toString());
        }
      }
      throw Exception("An unknown refresh token error occurred. Status: ${e.response?.statusCode}");
    }
  }
}