import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    _loadAuthState();

    on<UserSaved>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      emit(UserAuthorized());
    });

    on<UserLoggedOut>((event, emit) async {
      emit(AuthInitial());
    });
  }

  void _loadAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      emit(UserAuthorized());
    } else {
      emit(AuthInitial());
    }
  }
}
