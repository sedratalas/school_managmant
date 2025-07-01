part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}


class UserAuthorized extends AuthState {}

class Guest extends AuthState {}