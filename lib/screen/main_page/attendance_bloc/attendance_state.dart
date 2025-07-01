import 'package:equatable/equatable.dart';

import '../../../model/attendance_model.dart';


abstract class AttendanceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final Map<int, List<AttendanceModel>> studentAttendance;
  final DateTime selectedDate;

  AttendanceLoaded({
    required this.studentAttendance,
    required this.selectedDate,
  });

  @override
  List<Object?> get props => [studentAttendance, selectedDate];
}

class AttendanceError extends AttendanceState {
  final String message;

  AttendanceError({required this.message});

  @override
  List<Object?> get props => [message];
}
