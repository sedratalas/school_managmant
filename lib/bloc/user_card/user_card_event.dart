import 'package:equatable/equatable.dart';

abstract class UsersCardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchUsersCardStats extends UsersCardEvent {}
