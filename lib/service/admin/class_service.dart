import 'package:dio/dio.dart';
import 'package:school_managment/model/student_model.dart';

import '../../model/classes_model.dart';

class ClassService{
  ClassService({required this.dio});
  Dio dio;
  late Response response;
  String baseUrl = "https://school-managment-app-tqbh.onrender.com/admin/classes";

  Future<List<ClassModel>> getAllClass()async{
    try{
      response = await dio.get(baseUrl);
      List<ClassModel> classes = [];
      for(var i=0; i<response.data.length; i++){
        classes.add(ClassModel.fromJson(response.data[i]));
      }
      return classes;
    }catch(e){
      print(e);
      return [];
    }
  }

  Future<bool> createClass(ClassModel oneClass) async {
    try {
      response = await dio.post(baseUrl, data: oneClass.toJson());
      return true;
    } catch (e) {
      print("Error creating student: $e");
      return false;
    }
  }

}