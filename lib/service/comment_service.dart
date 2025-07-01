import 'package:dio/dio.dart';

import '../model/comment_model.dart';

class CommentService{
  CommentService({required this.dio});
  Dio dio;
  late Response response;
  String baseUrl = "https://school-managment-app-tqbh.onrender.com/parent/";

  Future<List<CommentModel>> getAllStudentComment(String studentId)async{
    try{
      response = await dio.get(baseUrl+"comments/"+studentId);
      List<CommentModel> comments = [];
      for(var i=0; i<response.data.lenght; i++){
        comments.add(CommentModel.fromJson(response.data[i]));
      }
      return comments;
    }catch(e){
      print(e);
      return [];
    }
  }

}