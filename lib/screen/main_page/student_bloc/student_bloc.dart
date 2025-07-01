import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../../../model/student_model.dart';
import '../../../service/admin/student_service.dart';
import 'student_event.dart';
import 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentService studentService;

  StudentBloc({required this.studentService}) : super(StudentInitial()) {
    on<LoadStudents>((event, emit) async {
      emit(StudentLoading());
      try {
        List<StudentModel> allStudents = await studentService.getAllStudent();
        List<StudentModel> parentStudents = allStudents.where((student) => student.parentId == event.parentId).toList();
        emit(StudentsLoaded(students: parentStudents));
      } catch (e) {
        emit(StudentError(message: 'Failed to load students: $e'));
      }
    });
  }
}
