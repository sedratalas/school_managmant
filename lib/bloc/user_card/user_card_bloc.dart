import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_managment/core/app_service.dart';
import 'package:school_managment/service/admin/crud_service.dart';
import 'package:school_managment/service/admin/student_service.dart';

import 'user_card_event.dart';
import 'user_card_state.dart';


class UsersCardBloc extends Bloc<UsersCardEvent, UsersCardState> {
  final StudentService studentService;
  final CrudService crudService;

  UsersCardBloc({
    required this.studentService,
    required this.crudService,
  }) : super(UsersCardInitial()) {
    on<FetchUsersCardStats>((event, emit) async {
      emit(UsersCardLoading());
      try {
        final stu = await studentService.getAllStudent();
        final parents = await crudService.getUsersByRole(UserRole.parent);
        final teachers = await crudService.getUsersByRole(UserRole.teacher);
        final bus = await crudService.getUsersByRole(UserRole.busMentor);

        emit(UsersCardLoaded(
          totalStudents: stu.length,
          totalParents: parents.length,
          totalTeachers: teachers.length,
          totalBusMentors: bus.length,
        ));
      } catch (e) {
        emit(UsersCardError(message: 'Failed to fetch user card statistics: $e'));
      }
    });
  }
}
