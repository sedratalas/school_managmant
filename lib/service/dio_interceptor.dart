import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:school_managment/bloc/auth/auth_bloc.dart';

class DioInterceptor extends Interceptor {
  final Dio dio;
  final AuthBloc authBloc;

  DioInterceptor({required this.dio, required this.authBloc});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('access_token');


    if (accessToken != null && !options.path.endsWith('/auth/login')) {
      options.headers['Authorization'] = 'Bearer $accessToken';
      print('[DioInterceptor] onRequest: Added Authorization header with access token.');
    } else {
      print('[DioInterceptor] onRequest: No access token found or it\'s a login request. Access token: $accessToken');
    }

    print('[DioInterceptor] Sending request: ${options.method} ${options.uri}');
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    print('[DioInterceptor] onError: Request error: ${err.requestOptions.uri}');
    print('[DioInterceptor] onError: Status code: $statusCode');


    if ((statusCode == 401 || statusCode == 403) && !err.requestOptions.path.endsWith('/auth/refresh')) {
      print('[DioInterceptor] onError: Attempting to refresh token...');

      final refreshed = await _refreshToken();

      if (refreshed) {
        final reqOptions = err.requestOptions;
        final prefs = await SharedPreferences.getInstance();
        final newToken = prefs.getString('access_token');

        if (newToken != null) {
          reqOptions.headers['Authorization'] = 'Bearer $newToken';
          print('[DioInterceptor] onError: Retrying request with new access token.');
        } else {
          reqOptions.headers.remove('Authorization');
          print('[DioInterceptor] onError: New access token not found after refresh, removing header.');
        }

        try {
          final clonedResponse = await dio.fetch(reqOptions);
          print('[DioInterceptor] onError: Token refreshed successfully. Retried request.');
          return handler.resolve(clonedResponse);
        } catch (e) {
          print('[DioInterceptor] onError: Failed to retry request: $e');
          return handler.next(err);
        }
      } else {

        print('[DioInterceptor] onError: Token refresh failed. Clearing tokens and logging out...');
        final prefs = await SharedPreferences.getInstance();
        await prefs.remove('access_token');
        await prefs.remove('refresh_token');
        await prefs.setBool('isLoggedIn', false);
        authBloc.add(UserLoggedOut());
      }
    } else if (statusCode == 403 && err.requestOptions.path.endsWith('/auth/refresh')) {

      print('[DioInterceptor] onError: Refresh token request failed with 403. Clearing tokens and logging out...');
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('access_token');
      await prefs.remove('refresh_token');
      await prefs.setBool('isLoggedIn', false);
      authBloc.add(UserLoggedOut());
    }

    print('[DioInterceptor] onError: Passing error to next handler.');
    return handler.next(err);
  }

  Future<bool> _refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refresh_token');
    final oldAccessToken = prefs.getString('access_token');

    print('[DioInterceptor] _refreshToken: Current refresh token from prefs: $refreshToken');
    print('[DioInterceptor] _refreshToken: Current old access token from prefs: $oldAccessToken');

    if (refreshToken == null) {
      print('[DioInterceptor] _refreshToken: No refresh token found, cannot refresh.');
      return false;
    }

    print('[DioInterceptor] _refreshToken: Sending refresh token request...');

    try {
      final response = await dio.post(
        'https://school-managment-app-tqbh.onrender.com/auth/refresh',
        data: {'refresh_token': refreshToken},
        options: Options(
          headers: {
            'Authorization': oldAccessToken != null ? 'Bearer $oldAccessToken' : null,
          },
        ),
      );

      final newAccessToken = response.data['access_token'];
      final newRefreshToken = response.data['refresh_token'];

      await prefs.setString('access_token', newAccessToken);
      await prefs.setString('refresh_token', newRefreshToken);

      print('[DioInterceptor] _refreshToken: Token refresh successful. New access: $newAccessToken, New refresh: $newRefreshToken');
      return true;
    } on DioException catch (e) {
      print('[DioInterceptor] _refreshToken: Refresh request failed: $e');
      return false;
    } catch (e) {
      print('[DioInterceptor] _refreshToken: Unexpected error during refresh: $e');
      return false;
    }
  }
}
