import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// import 'app.dart';
// void main() async{
//   // if (kDebugMode) {
//   //   final authRepo = AuthRepository(authService: AuthService(dio: Dio()));
//   //   await authRepo.clearUserData();
//   // }
//   runApp(
//     DevicePreview(
//         enabled: !kReleaseMode,
//         builder: (BuildContext context) => MyApp()) ,
//
//   );
// }
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:school_managment/app.dart';
import 'package:school_managment/repo/auth_repositery.dart';
import 'package:school_managment/service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'core/app_service.dart';
import 'model/student_model.dart';
import 'model/admin/user_model.dart';

import 'service/admin/crud_service.dart';
import 'service/admin/student_service.dart';
import 'service/dio_interceptor.dart';

void main() async {
  final prefs = await SharedPreferences.getInstance();
  print("[Startup] access_token: ${prefs.getString('access_token')}");
  print("[Startup] refresh_token: ${prefs.getString('refresh_token')}");

  WidgetsFlutterBinding.ensureInitialized();

  // final authRepo = AuthRepository(authService: AuthService(dio: Dio()));
  // await authRepo.clearUserData();
  runApp(
      MyApp()
  );
}
