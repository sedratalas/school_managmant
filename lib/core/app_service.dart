import 'package:dio/dio.dart';
import '../service/admin/class_service.dart';
import '../service/admin/crud_service.dart';
import '../service/admin/student_service.dart';

class AppServices {
  static late Dio dio;

  static void init(Dio dioInstance) {
    dio = dioInstance;
  }

  static StudentService get studentService => StudentService(dio: dio);
  static CrudService get crudService => CrudService(dio: dio);
  static final ClassService classService = ClassService(dio: dio);
}
