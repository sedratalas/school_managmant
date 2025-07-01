import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/login_model.dart';
import '../../../repo/auth_repositery.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<TryLogin>((event, emit) async {
      emit(LoadingState());
      try {
        await authRepository.login(event.user);

        emit(LoginSuccess());
      } catch (e) {
        emit(LoginFailure(error: e.toString()));
      }
    });
  }
}
