import 'package:equatable/equatable.dart';
import 'package:school_managment/model/classes_model.dart';

abstract class ClassesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchClasses extends ClassesEvent {}

class AddClass extends ClassesEvent {
  final ClassModel newClass;

  AddClass({required this.newClass});

  @override
  List<Object?> get props => [newClass];
}
