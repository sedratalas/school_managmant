import 'package:equatable/equatable.dart';
import 'package:school_managment/model/classes_model.dart';


abstract class ClassesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ClassesInitial extends ClassesState {}

class ClassesLoading extends ClassesState {}

class ClassesLoaded extends ClassesState {
  final List<ClassModel> classes;

  ClassesLoaded({required this.classes});

  @override
  List<Object?> get props => [classes];
}

class ClassesError extends ClassesState {
  final String message;

  ClassesError({required this.message});

  @override
  List<Object?> get props => [message];
}

class ClassAdding extends ClassesState {}

class ClassAddedSuccess extends ClassesState {}

class ClassAddFailure extends ClassesState {
  final String message;

  ClassAddFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
