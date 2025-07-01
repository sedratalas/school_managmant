import 'package:equatable/equatable.dart';


abstract class UsersCardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UsersCardInitial extends UsersCardState {}

class UsersCardLoading extends UsersCardState {}

class UsersCardLoaded extends UsersCardState {
  final int totalStudents;
  final int totalParents;
  final int totalTeachers;
  final int totalBusMentors;

  UsersCardLoaded({
    required this.totalStudents,
    required this.totalParents,
    required this.totalTeachers,
    required this.totalBusMentors,
  });

  @override
  List<Object?> get props => [totalStudents, totalParents, totalTeachers, totalBusMentors];
}

class UsersCardError extends UsersCardState {
  final String message;

  UsersCardError({required this.message});

  @override
  List<Object?> get props => [message];
}
