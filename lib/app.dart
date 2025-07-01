import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'bloc/auth/auth_bloc.dart';
import 'bloc/classes/classes_bloc.dart';
import 'bloc/data_table_management/data_table_bloc.dart';
import 'bloc/user_card/user_card_bloc.dart';
import 'core/app_service.dart';
import 'repo/auth_repositery.dart';
import 'screen/login/bloc/login_bloc.dart';
import 'screen/login/login_screen.dart';
import 'screen/main_page/home_screen.dart';
import 'service/auth_service.dart';
import 'service/dio_interceptor.dart';


class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = AuthBloc();
    final dio = Dio();

    dio.interceptors.add(DioInterceptor(dio: dio, authBloc: authBloc));

    // تهيئة AppServices
    AppServices.init(dio);

    final authRepository = AuthRepository(authService: AuthService(dio: dio));

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: authBloc),
        BlocProvider<LoginBloc>(
          create: (_) => LoginBloc(authRepository: authRepository),
        ),
        BlocProvider<UsersCardBloc>(
          create: (context) => UsersCardBloc(
            studentService: AppServices.studentService,
            crudService: AppServices.crudService,
          ),
        ),
        BlocProvider<ClassesBloc>(
          create: (context) => ClassesBloc(
            classService: AppServices.classService,
          ),
        ),
        BlocProvider<DataTableBloc>(
          create: (context) => DataTableBloc(
            studentService: AppServices.studentService,
            crudService: AppServices.crudService,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is UserAuthorized) {
              return DashboardPage();
            } else {
              return LoginScreen();
            }
          },
        ),
      ),
    );
  }
}
