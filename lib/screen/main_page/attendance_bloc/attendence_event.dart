import 'package:equatable/equatable.dart';

abstract class AttendanceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAttendanceForStudents extends AttendanceEvent {
  final List<int> studentIds;
  final DateTime date;

  LoadAttendanceForStudents({required this.studentIds, required this.date});

  @override
  List<Object?> get props => [studentIds, date];
}

class ChangeAttendanceDate extends AttendanceEvent {
  final DateTime newDate;
  final List<int> studentIds;

  ChangeAttendanceDate({required this.newDate, required this.studentIds});

  @override
  List<Object?> get props => [newDate, studentIds];
}
