import 'package:dio/dio.dart';
import '../model/attendance_model.dart';

class AttendanceService {
  AttendanceService({required this.dio});
  Dio dio;
  String baseUrl = "https://school-managment-app-tqbh.onrender.com/parent/";

  Future<List<AttendanceModel>> getAttendanceForStudent(int studentId, DateTime startDate, DateTime endDate) async {
    try {
      final String formattedStartDate = "${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}";
      final String formattedEndDate = "${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}";

      Response response = await dio.get(
        "$baseUrl/attendance/$studentId",
        queryParameters: {
          "start_date": formattedStartDate,
          "end_date": formattedEndDate,
        },
      );
      List<AttendanceModel> attendanceRecords = [];
      if (response.data != null && response.data is List) {
        for (var record in response.data) {
          attendanceRecords.add(AttendanceModel.fromJson(record));
        }
      }
      return attendanceRecords;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
