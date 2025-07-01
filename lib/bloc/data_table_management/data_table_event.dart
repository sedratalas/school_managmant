import 'package:equatable/equatable.dart';
import 'package:school_managment/model/admin/create_user_model.dart';
import 'package:school_managment/model/student_model.dart';
import 'package:school_managment/service/admin/crud_service.dart';

abstract class DataTableEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchDataTable extends DataTableEvent {
  final String dataType;

  FetchDataTable({required this.dataType});

  @override
  List<Object?> get props => [dataType];
}

class UpdateStudentField extends DataTableEvent {
  final num studentId;
  final String fieldName;
  final String newValue;

  UpdateStudentField({required this.studentId, required this.fieldName, required this.newValue});

  @override
  List<Object?> get props => [studentId, fieldName, newValue];
}

class AddNewEntry extends DataTableEvent {
  final String entryType;
  final StudentModel? studentData;
  final CreateUserModel? userData;
  final UserRole? userRole;

  AddNewEntry({
    required this.entryType,
    this.studentData,
    this.userData,
    this.userRole,
  });

  @override
  List<Object?> get props => [entryType, studentData, userData, userRole];
}
