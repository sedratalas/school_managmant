// import 'package:dio/dio.dart';
// import 'package:school_managment/model/student_model.dart';
//
// class StudentService{
//   StudentService({required this.dio});
//   Dio dio;
//   late Response response;
//   String baseUrl = "https://school-managment-app-tqbh.onrender.com/admin/students";
//
//   Future<List<StudentModel>> getAllStudent()async{
//     try{
//       response = await dio.get(baseUrl);
//       List<StudentModel> students = [];
//       for(var i=0; i<response.data.length; i++){
//         students.add(StudentModel.fromJson(response.data[i]));
//       }
//       return students;
//     }catch(e){
//       print(e);
//       return [];
//     }
//   }
//
//   Future<bool> createStudent(StudentModel student) async {
//     try {
//       response = await dio.post(baseUrl, data: student.toJson());
//       return true;
//     } catch (e) {
//       print("Error creating student: $e");
//       return false;
//     }
//   }
//
// }

import 'package:dio/dio.dart';
import 'package:school_managment/model/student_model.dart';

class StudentService {
  StudentService({required this.dio});
  Dio dio;
  late Response response;
  String baseUrl = "https://school-managment-app-tqbh.onrender.com/admin/students";

  Future<List<StudentModel>> getAllStudent() async {
    try {
      response = await dio.get(baseUrl);
      List<StudentModel> students = [];
      for (var i = 0; i < response.data.length; i++) {
        students.add(StudentModel.fromJson(response.data[i]));
      }
      return students;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> createStudent(StudentModel student) async {
    try {
      response = await dio.post(baseUrl, data: student.toJson());
      return true;
    } catch (e) {
      print("Error creating student: $e");
      return false;
    }
  }


  Future<bool> updateStudentFees(num studentId, num newFees) async {
    try {
      await dio.patch(
        '$baseUrl/$studentId/fees',
        data: {"fees": newFees},
      );
      return true;
    } on DioException catch (e) {
      print("Error updating student fees: $e");
      return false;
    } catch (e) {
      print("Unexpected error updating student fees: $e");
      return false;
    }
  }


  Future<bool> updateStudentClassId(num studentId, num newClassId) async {
    try {
      await dio.patch(
        '$baseUrl/$studentId/class',
        data: {"class_id": newClassId},
      );
      return true;
    } on DioException catch (e) {
      print("Error updating student class ID: $e");
      return false;
    } catch (e) {
      print("Unexpected error updating student class ID: $e");
      return false;
    }
  }
}