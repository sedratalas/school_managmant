//
//
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../model/login_model.dart';
// import '../service/auth_service.dart';
//
//
// class AuthRepository {
//   final AuthService authService;
//
//   AuthRepository({required this.authService});
//
//   Future<String?> login(LoginModel user) => authService.logIn(user);
//   Future<void> clearUserData() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     await prefs.remove('isLoggedIn');
//     // await prefs.remove('authToken');
//     print('User data cleared from SharedPreferences.'); // للتحقق في Debug Console
//   }
// }
import 'package:shared_preferences/shared_preferences.dart';

import '../model/login_model.dart';
import '../model/token_model.dart';  // افترضنا نقلت TokenModel لموديل منفصل
import '../service/auth_service.dart';

class AuthRepository {
  final AuthService authService;

  AuthRepository({required this.authService});

  Future<void> login(LoginModel user) async {
    final tokens = await authService.logIn(user);
    await saveTokens(tokens);
  }

  Future<TokenModel> refreshToken() async {
    final refreshToken = await getRefreshToken();
    if (refreshToken == null) {
      throw Exception('No refresh token found');
    }
    final tokens = await authService.refreshToken(refreshToken);
    await saveTokens(tokens);
    return tokens;
  }

  Future<void> saveTokens(TokenModel tokens) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', tokens.accessToken);
    await prefs.setString('refresh_token', tokens.refreshToken);

  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refresh_token');
  }

  Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    await prefs.remove('isLoggedIn');
    print('User data cleared from SharedPreferences.');
  }
}
