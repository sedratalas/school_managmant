import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:school_managment/core/app_service.dart';
import 'package:school_managment/model/classes_model.dart';
import 'package:school_managment/service/admin/class_service.dart';

import 'classes_event.dart';
import 'classes_state.dart';


class ClassesBloc extends Bloc<ClassesEvent, ClassesState> {
  final ClassService classService;

  ClassesBloc({required this.classService}) : super(ClassesInitial()) {
    on<FetchClasses>((event, emit) async {
      emit(ClassesLoading());
      try {
        final classes = await classService.getAllClass();
        emit(ClassesLoaded(classes: classes));
      } catch (e) {
        emit(ClassesError(message: 'Failed to fetch classes: $e'));
      }
    });

    on<AddClass>((event, emit) async {
      emit(ClassAdding());
      try {
        bool success = await classService.createClass(event.newClass);
        if (success) {
          emit(ClassAddedSuccess());
          add(FetchClasses());
        } else {
          emit(ClassAddFailure(message: 'Failed to add class.'));
        }
      } catch (e) {
        emit(ClassAddFailure(message: 'Error adding class: $e'));
      }
    });
  }
}
