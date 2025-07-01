import 'package:equatable/equatable.dart';

abstract class StudentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadStudents extends StudentEvent {
  final int parentId;

  LoadStudents({required this.parentId});

  @override
  List<Object?> get props => [parentId];
}
