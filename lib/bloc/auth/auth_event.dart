part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}


class UserSaved extends AuthEvent {}
class UserLoggedOut extends AuthEvent {}
