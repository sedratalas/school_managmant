import 'package:bloc/bloc.dart';
import 'package:school_managment/model/student_model.dart';
import 'package:school_managment/service/admin/crud_service.dart';
import 'package:school_managment/service/admin/student_service.dart';
import 'data_table_event.dart';
import 'data_table_state.dart';



class DataTableBloc extends Bloc<DataTableEvent, DataTableState> {
  final StudentService studentService;
  final CrudService crudService;

  DataTableBloc({
    required this.studentService,
    required this.crudService,
  }) : super(DataTableInitial()) {
    on<FetchDataTable>((event, emit) async {
      emit(DataTableLoading(currentType: event.dataType));
      try {
        List<dynamic> data = [];
        if (event.dataType == "student") {
          data = await studentService.getAllStudent();
        } else {
          UserRole role;
          if (event.dataType == "parent") {
            role = UserRole.parent;
          } else if (event.dataType == "teacher") {
            role = UserRole.teacher;
          } else if (event.dataType == "busMentor") {
            role = UserRole.busMentor;
          } else {
            throw Exception("Unknown data type: ${event.dataType}");
          }
          data = await crudService.getUsersByRole(role);
        }
        emit(DataTableLoaded(data: data, currentType: event.dataType));
      } catch (e) {
        emit(DataTableError(message: 'Failed to fetch data: $e', currentType: event.dataType));
      }
    });

    on<UpdateStudentField>((event, emit) async {
      if (state is! DataTableLoaded) {
        return;
      }
      final currentState = state as DataTableLoaded;
      final List<dynamic> currentData = List.from(currentState.data);
      final studentToUpdateIndex = currentData.indexWhere((s) => s is StudentModel && s.id == event.studentId);

      if (studentToUpdateIndex == -1) {
        emit(DataUpdateFailure(currentData: currentData, currentType: currentState.currentType, message: 'Student not found.'));
        return;
      }

      StudentModel student = currentData[studentToUpdateIndex] as StudentModel;
      bool success = false;

      emit(DataUpdating(currentData: currentData, currentType: currentState.currentType));

      try {
        if (event.fieldName == 'fees') {
          final num? newFees = num.tryParse(event.newValue);
          if (newFees != null) {
            success = await studentService.updateStudentFees(student.id, newFees);
            if (success) {
              currentData[studentToUpdateIndex] = student.copyWith(fees: newFees);
            }
          }
        } else if (event.fieldName == 'class_id') {
          final int? newClassId = int.tryParse(event.newValue);
          if (newClassId != null) {
            success = await studentService.updateStudentClassId(student.id, newClassId);
            if (success) {
              currentData[studentToUpdateIndex] = student.copyWith(classId: newClassId);
            }
          }
        }

        if (success) {
          emit(DataUpdateSuccess(updatedData: currentData, currentType: currentState.currentType, message: 'Updated successfully!'));
          emit(DataTableLoaded(data: currentData, currentType: currentState.currentType));
        } else {
          emit(DataUpdateFailure(currentData: currentData, currentType: currentState.currentType, message: 'Failed to update.'));
        }
      } catch (e) {
        emit(DataUpdateFailure(currentData: currentData, currentType: currentState.currentType, message: 'Error updating data: $e'));
      }
    });

    on<AddNewEntry>((event, emit) async {
      emit(DataAdding(currentType: event.entryType));
      bool success = false;
      try {
        if (event.entryType == "student" && event.studentData != null) {
          success = await studentService.createStudent(event.studentData!);
        } else if (event.userData != null && event.userRole != null) {
          success = await crudService.createUserByRole(event.userData!, event.userRole!);
        }

        if (success) {
          emit(DataAddSuccess(currentType: event.entryType, message: 'Entry added successfully.'));
          add(FetchDataTable(dataType: event.entryType));
        } else {
          emit(DataAddFailure(currentType: event.entryType, message: 'Failed to add entry.'));
        }
      } catch (e) {
        emit(DataAddFailure(currentType: event.entryType, message: 'Error adding entry: $e'));
      }
    });
  }
}
