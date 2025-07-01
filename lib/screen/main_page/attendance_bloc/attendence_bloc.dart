import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import '../../../model/attendance_model.dart';
import '../../../service/attendence_server.dart';
import 'attendance_state.dart';
import 'attendence_event.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceService attendanceService;

  AttendanceBloc({required this.attendanceService}) : super(AttendanceInitial()) {
    on<LoadAttendanceForStudents>((event, emit) async {
      emit(AttendanceLoading());
      try {
        Map<int, List<AttendanceModel>> attendanceMap = {};
        for (var studentId in event.studentIds) {
          List<AttendanceModel> attendance = await attendanceService.getAttendanceForStudent(
            studentId,
            event.date,
            event.date,
          );
          attendanceMap[studentId] = attendance;
        }
        emit(AttendanceLoaded(
          studentAttendance: attendanceMap,
          selectedDate: event.date,
        ));
      } catch (e) {
        emit(AttendanceError(message: 'Failed to load attendance: $e'));
      }
    });

    on<ChangeAttendanceDate>((event, emit) async {
      emit(AttendanceLoading());
      try {
        Map<int, List<AttendanceModel>> attendanceMap = {};
        for (var studentId in event.studentIds) {
          List<AttendanceModel> attendance = await attendanceService.getAttendanceForStudent(
            studentId,
            event.newDate,
            event.newDate,
          );
          attendanceMap[studentId] = attendance;
        }
        emit(AttendanceLoaded(
          studentAttendance: attendanceMap,
          selectedDate: event.newDate,
        ));
      } catch (e) {
        emit(AttendanceError(message: 'Failed to change attendance date: $e'));
      }
    });
  }
}
