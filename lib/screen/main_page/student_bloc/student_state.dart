import 'package:equatable/equatable.dart';

import '../../../model/student_model.dart';


abstract class StudentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StudentInitial extends StudentState {}

class StudentLoading extends StudentState {}

class StudentsLoaded extends StudentState {
  final List<StudentModel> students;

  StudentsLoaded({required this.students});

  @override
  List<Object?> get props => [students];
}

class StudentError extends StudentState {
  final String message;

  StudentError({required this.message});

  @override
  List<Object?> get props => [message];
}
