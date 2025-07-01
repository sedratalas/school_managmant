// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:school_managment/core/app_service.dart';
// import 'package:shimmer/shimmer.dart';
//
//
// import '../../model/admin/create_user_model.dart';
// import '../../model/admin/user_model.dart';
// import '../../model/student_model.dart';
// import '../../service/admin/crud_service.dart';
// import '../../service/admin/student_service.dart';
//
// class DashboardPage extends StatefulWidget {
//
//   @override
//   State<DashboardPage> createState() => _DashboardPageState();
// }
//
// class _DashboardPageState extends State<DashboardPage> {
//
//   List<dynamic> currentData = [];
//   String currentType = "";
//
//   bool isLoading = false;
//   bool statsLoading = false;
//
//   int totalStudents = 0, totalParents = 0, totalTeachers = 0, totalBusMentors = 0;
//
//
//   @override
//   void initState() {
//     super.initState();
//     fetchStats();
//   }
//
//   Future<void> fetchStats() async {
//     setState(() => statsLoading = true);
//
//     try {
//       final stu = await AppServices.studentService.getAllStudent();
//       final parents = await AppServices.crudService.getUsersByRole(UserRole.parent);
//       final teachers = await AppServices.crudService.getUsersByRole(UserRole.teacher);
//       final bus = await AppServices.crudService.getUsersByRole(UserRole.busMentor);
//
//       setState(() {
//         totalStudents = stu.length;
//         totalParents = parents.length;
//         totalTeachers = teachers.length;
//         totalBusMentors = bus.length;
//       });
//     } catch (e) {
//       print(e);
//     } finally {
//       setState(() => statsLoading = false);
//     }
//   }
//
//   Future<void> fetchStudents() async {
//     setState(() {
//       isLoading = true;
//       currentType = "student";
//     });
//     final students = await AppServices.studentService.getAllStudent();
//     setState(() {
//       currentData = students;
//       isLoading = false;
//     });
//   }
//
//   Future<void> fetchUsers(UserRole role) async {
//     setState(() {
//       isLoading = true;
//       currentType = role.name;
//     });
//     final users = await AppServices.crudService.getUsersByRole(role);
//     setState(() {
//       currentData = users;
//       isLoading = false;
//     });
//   }
//
//   Widget _buildStatCard(String title, int count, Color color, VoidCallback onTap) {
//     return GestureDetector(
//       onTap: onTap,
//       child: statsLoading
//           ? Shimmer.fromColors(
//         baseColor: Colors.grey.shade300,
//         highlightColor: Colors.grey.shade100,
//         child: Container(
//           height: 100,
//           width: 200,
//           margin: const EdgeInsets.symmetric(horizontal: 6),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(15),
//           ),
//         ),
//       )
//           : Container(
//         height: 100,
//         width: 200,
//         margin: const EdgeInsets.symmetric(horizontal: 6),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.2),
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
//             SizedBox(height: 8),
//             Text(count.toString(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTableHeader() {
//     if (currentType == "student") {
//       return Row(
//         children: [
//           Expanded(child: Text("ID", style: TextStyle(fontWeight: FontWeight.bold))),
//           Expanded(child: Text("Name", style: TextStyle(fontWeight: FontWeight.bold))),
//           Expanded(child: Text("Class ID", style: TextStyle(fontWeight: FontWeight.bold))),
//           Expanded(child: Text("Parent ID", style: TextStyle(fontWeight: FontWeight.bold))),
//           Expanded(child: Text("Fees", style: TextStyle(fontWeight: FontWeight.bold))),
//         ],
//       );
//     } else if (["parent", "teacher", "busMentor"].contains(currentType)) {
//       return Row(
//         children: [
//           Expanded(child: Text("ID", style: TextStyle(fontWeight: FontWeight.bold))),
//           Expanded(child: Text("Username", style: TextStyle(fontWeight: FontWeight.bold))),
//           Expanded(child: Text("Phone", style: TextStyle(fontWeight: FontWeight.bold))),
//           Expanded(child: Text("Role", style: TextStyle(fontWeight: FontWeight.bold))),
//           Expanded(child: Text("Active", style: TextStyle(fontWeight: FontWeight.bold))),
//         ],
//       );
//     } else {
//       return Center(child: Text("Select a category to display data."));
//     }
//   }
//
//   Widget _buildTableRow(dynamic item) {
//     if (item is StudentModel) {
//       return Row(
//         children: [
//           Expanded(child: Text(item.id.toString())),
//           Expanded(child: Text(item.name)),
//           Expanded(child: Text(item.classId.toString())),
//           Expanded(child: Text(item.parentId.toString())),
//           Expanded(child: Text(item.fees.toString())),
//         ],
//       );
//     } else if (item is UserModel) {
//       return Row(
//         children: [
//           Expanded(child: Text(item.id.toString())),
//           Expanded(child: Text(item.username)),
//           Expanded(child: Text(item.phoneNumber)),
//           Expanded(child: Text(item.role)),
//           Expanded(child: Text(item.isActive ? "Yes" : "No")),
//         ],
//       );
//     } else {
//       return SizedBox.shrink();
//     }
//   }
//
//   Widget _buildSidebar() {
//     return Container(
//       width: 60,
//       color: Color(0xFF90A38A),
//       child: Column(
//         children: [
//           SizedBox(height: 20),
//           Icon(Icons.dashboard, color: Colors.white),
//           SizedBox(height: 20),
//           Icon(Icons.analytics, color: Colors.white),
//           SizedBox(height: 20),
//           Icon(Icons.inventory, color: Colors.white),
//           SizedBox(height: 20),
//           Icon(Icons.settings, color: Colors.white),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF1F3F0),
//       body: Row(
//         children: [
//           _buildSidebar(),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: [
//                   // Header
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text("Good Evening, admin", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
//                       Row(
//                         children: [
//                           Icon(Icons.notifications_none),
//                           SizedBox(width: 10),
//                           Icon(Icons.account_circle_outlined),
//                           SizedBox(width: 10),
//                         ],
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//
//                   // Stat Cards
//                   Row(
//                     children: [
//                       _buildStatCard("Students", totalStudents, Colors.green, fetchStudents),
//                       _buildStatCard("Parents", totalParents, Colors.orange, () => fetchUsers(UserRole.parent)),
//                       _buildStatCard("Teachers", totalTeachers, Colors.purple, () => fetchUsers(UserRole.teacher)),
//                       _buildStatCard("Bus Mentors", totalBusMentors, Colors.red, () => fetchUsers(UserRole.busMentor)),
//                     ],
//                   ),
//                   SizedBox(height: 16),
//
//                   // Data Table Card
//                   Expanded(
//                     child: Card(
//                       child: Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text("Data Table", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                                 ),
//                                 Expanded(child: SizedBox(width: 8)),
//                                 ElevatedButton.icon(
//                                   icon: Icon(Icons.add),
//                                   label: Text("Add New"),
//                                   onPressed: () => showAddDialog(context, currentType),
//                                 ),
//                                 SizedBox(height: 8),
//
//                               ],
//                             ),
//                             Divider(),
//                             _buildTableHeader(),
//                             Divider(),
//                             Expanded(
//                               child: isLoading
//                                   ? ListView.builder(
//                                 itemCount: 6,
//                                 itemBuilder: (_, __) => Padding(
//                                   padding: const EdgeInsets.symmetric(vertical: 6),
//                                   child: Shimmer.fromColors(
//                                     baseColor: Colors.grey.shade300,
//                                     highlightColor: Colors.grey.shade100,
//                                     child: Row(
//                                       children: List.generate(
//                                         5,
//                                             (_) => Expanded(
//                                           child: Container(
//                                             height: 20,
//                                             margin: EdgeInsets.symmetric(horizontal: 4),
//                                             color: Colors.white,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               )
//                                   : currentData.isEmpty
//                                   ? Center(child: Text("No data available"))
//                                   : ListView.builder(
//                                 itemCount: currentData.length,
//                                 itemBuilder: (context, index) => Padding(
//                                   padding: const EdgeInsets.symmetric(vertical: 6),
//                                   child: _buildTableRow(currentData[index]),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// Future<void> showAddDialog(BuildContext context, String type) async {
//   final formKey = GlobalKey<FormState>();
//
//   String username = '';
//   String phoneNumber = '';
//   String password = '';
//   String name = '';
//   num classId = 0;
//   num parentId = 0;
//   num fees = 0;
//
//   return showDialog<void>(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Add New ${type == "student" ? "Student" : "User"}'),
//         content: SingleChildScrollView(
//           child: Form(
//             key: formKey,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 if (type == "student") ...[
//                   TextFormField(
//                     decoration: InputDecoration(labelText: 'Name'),
//                     onChanged: (val) => name = val,
//                     validator: (val) => val == null || val.isEmpty ? 'Required' : null,
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(labelText: 'Class ID'),
//                     keyboardType: TextInputType.number,
//                     onChanged: (val) => classId = num.tryParse(val) ?? 0,
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(labelText: 'Parent ID'),
//                     keyboardType: TextInputType.number,
//                     onChanged: (val) => parentId = num.tryParse(val) ?? 0,
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(labelText: 'Fees'),
//                     keyboardType: TextInputType.number,
//                     onChanged: (val) => fees = num.tryParse(val) ?? 0,
//                   ),
//                 ] else ...[
//                   TextFormField(
//                     decoration: InputDecoration(labelText: 'Username'),
//                     onChanged: (val) => username = val,
//                     validator: (val) => val == null || val.isEmpty ? 'Required' : null,
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(labelText: 'Phone Number'),
//                     onChanged: (val) => phoneNumber = val,
//                   ),
//                   TextFormField(
//                     decoration: InputDecoration(labelText: 'Password'),
//                     obscureText: true,
//                     onChanged: (val) => password = val,
//                     validator: (val) => val == null || val.isEmpty ? 'Required' : null,
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: Text('Cancel'),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           ElevatedButton(
//             child: Text('Add'),
//             onPressed: () async {
//               if (formKey.currentState!.validate()) {
//                 bool success = false;
//                 if (type == "student") {
//                   StudentModel newStudent = StudentModel(
//                     name: name,
//                     classId: classId,
//                     parentId: parentId,
//                     profilePicture: '',
//                     fees: fees,
//                     id: 0,
//                   );
//                   success = await AppServices.studentService.createStudent(newStudent);
//                 } else {
//                   UserRole role;
//                   if (type == "parent") {
//                     role = UserRole.parent;
//                   } else if (type == "teacher") {
//                     role = UserRole.teacher;
//                   } else {
//                     role = UserRole.busMentor;
//                   }
//                   CreateUserModel newUser = CreateUserModel(
//                     username: username,
//                     phoneNumber: phoneNumber,
//                     password: password,
//                   );
//                   success = await AppServices.crudService.createUserByRole(newUser, role);
//                 }
//                 if (success) {
//                   Navigator.of(context).pop();
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('success.')),
//                   );
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Failed to add. Please try again.')),
//                   );
//                 }
//               }
//             },
//           ),
//         ],
//       );
//     },
//   );
// }

/*import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:school_managment/core/app_service.dart';
import 'package:shimmer/shimmer.dart';

import '../../model/admin/create_user_model.dart';
import '../../model/admin/user_model.dart';
import '../../model/student_model.dart';
import '../../service/admin/crud_service.dart';
import '../../service/admin/student_service.dart';

class StatCardPainter extends CustomPainter {
  final Color cardColor;
  final Color curveAccentColor;

  StatCardPainter({required this.cardColor, required this.curveAccentColor});

  @override
  void paint(Canvas canvas, Size size) {
    final RRect rRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(15),
    );
    final cardPaint = Paint()..color = cardColor;
    canvas.drawRRect(rRect, cardPaint);

    final wavePaint = Paint()
      ..color = curveAccentColor
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.8);

    path.cubicTo(
      size.width * 0.25, size.height * 0.7,
      size.width * 0.25, size.height * 0.9,
      size.width * 0.5, size.height * 0.8,
    );

    path.cubicTo(
      size.width * 0.75, size.height * 0.7,
      size.width * 0.75, size.height * 0.9,
      size.width, size.height * 0.8,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(covariant StatCardPainter oldDelegate) {
    return oldDelegate.cardColor != cardColor || oldDelegate.curveAccentColor != curveAccentColor;
  }
}

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<dynamic> currentData = [];
  String currentType = "";

  bool isLoading = false;
  bool statsLoading = false;

  int totalStudents = 0, totalParents = 0, totalTeachers = 0, totalBusMentors = 0;

  @override
  void initState() {
    super.initState();
    fetchStats();
  }

  Future<void> fetchStats() async {
    setState(() => statsLoading = true);

    try {
      final stu = await AppServices.studentService.getAllStudent();
      final parents = await AppServices.crudService.getUsersByRole(UserRole.parent);
      final teachers = await AppServices.crudService.getUsersByRole(UserRole.teacher);
      final bus = await AppServices.crudService.getUsersByRole(UserRole.busMentor);

      setState(() {
        totalStudents = stu.length;
        totalParents = parents.length;
        totalTeachers = teachers.length;
        totalBusMentors = bus.length;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() => statsLoading = false);
    }
  }

  Future<void> fetchStudents() async {
    setState(() {
      isLoading = true;
      currentType = "student";
    });
    final students = await AppServices.studentService.getAllStudent();
    setState(() {
      currentData = students;
      isLoading = false;
    });
  }

  Future<void> fetchUsers(UserRole role) async {
    setState(() {
      isLoading = true;
      currentType = role.name;
    });
    final users = await AppServices.crudService.getUsersByRole(role);
    setState(() {
      currentData = users;
      isLoading = false;
    });
  }

  Widget _buildStatCard(String title, int count, Color color, VoidCallback onTap) {
    final Color cardBackgroundColor = color.withOpacity(0.8);
    final Color waveAccentColor = Colors.black.withOpacity(0.1);

    return GestureDetector(
      onTap: onTap,
      child: statsLoading
          ? Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: 120,
          width: 200,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      )
          : Container(
        height: 120,
        width: 200,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: StatCardPainter(
                    cardColor: cardBackgroundColor,
                    curveAccentColor: waveAccentColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white.withOpacity(0.9))),
                    SizedBox(height: 8),
                    Text(count.toString(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    if (currentType == "student") {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(child: Text("ID", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
            Expanded(child: Text("Name", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
            Expanded(child: Text("Class ID", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
            Expanded(child: Text("Parent ID", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
            Expanded(child: Text("Fees", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
          ],
        ),
      );
    } else if (["parent", "teacher", "busMentor"].contains(currentType)) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(child: Text("ID", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
            Expanded(child: Text("Username", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
            Expanded(child: Text("Phone", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
            Expanded(child: Text("Role", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
            Expanded(child: Text("Active", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13))),
          ],
        ),
      );
    } else {
      return Center(child: Text("Select a category to display data."));
    }
  }

  Widget _buildTableRow(dynamic item, int index) {
    Color rowColor = index % 2 == 0 ? Colors.white : Colors.grey[50]!;
    if (item is StudentModel) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        color: rowColor,
        child: Row(
          children: [
            Expanded(child: Text(item.id.toString(), style: TextStyle(fontSize: 13))),
            Expanded(child: Text(item.name, style: TextStyle(fontSize: 13))),
            Expanded(child: Text(item.classId.toString(), style: TextStyle(fontSize: 13))),
            Expanded(child: Text(item.parentId.toString(), style: TextStyle(fontSize: 13))),
            Expanded(child: Text(item.fees.toString(), style: TextStyle(fontSize: 13))),
          ],
        ),
      );
    } else if (item is UserModel) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        color: rowColor,
        child: Row(
          children: [
            Expanded(child: Text(item.id.toString(), style: TextStyle(fontSize: 13))),
            Expanded(child: Text(item.username, style: TextStyle(fontSize: 13))),
            Expanded(child: Text(item.phoneNumber, style: TextStyle(fontSize: 13))),
            Expanded(child: Text(item.role, style: TextStyle(fontSize: 13))),
            Expanded(child: Text(item.isActive ? "Yes" : "No", style: TextStyle(fontSize: 13))),
          ],
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _buildSidebar() {
    return Container(
        width: 60,
        color: Color(0xFF90A38A),
    child: Column(
    children: [
    SizedBox(height: 20),
    Icon(Icons.dashboard, color: Colors.white),
    SizedBox(height: 20),
    Icon(Icons.analytics, color: Colors.white),
    SizedBox(height: 20),
    Icon(Icons.inventory, color: Colors.white),
    SizedBox(height: 20),
    Icon(Icons.settings, color: Colors.white),
    ],
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F3F0),
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Good Evening, admin", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Icon(Icons.notifications_none),
                          SizedBox(width: 10),
                          Icon(Icons.account_circle_outlined),
                          SizedBox(width: 10),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  Row(
                    children: [
                      _buildStatCard("Students", totalStudents, Color(0xffA1BF99), fetchStudents),
                      _buildStatCard("Parents", totalParents, Color(0xffFFCF94), () => fetchUsers(UserRole.parent)),
                      _buildStatCard("Teachers", totalTeachers, Color(0xffB898C1), () => fetchUsers(UserRole.teacher)),
                      _buildStatCard("Bus Mentors", totalBusMentors, Color(0xffC19999), () => fetchUsers(UserRole.busMentor)),
                    ],
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 3,
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 850),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Data Table", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  ElevatedButton.icon(
                                    icon: Icon(Icons.add),
                                    label: Text("Add New"),
                                    onPressed: () => showAddDialog(context, currentType),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              _buildTableHeader(),
                              SizedBox(height: 4),
                              Expanded(
                                child: isLoading
                                    ? ListView.builder(
                                  itemCount: 6,
                                  itemBuilder: (_, __) => Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 6),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Row(
                                        children: List.generate(
                                          5,
                                              (_) => Expanded(
                                            child: Container(
                                              height: 20,
                                              margin: EdgeInsets.symmetric(horizontal: 4),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                    : currentData.isEmpty
                                    ? Center(child: Text("No data available"))
                                    : ListView.builder(
                                  itemCount: currentData.length,
                                  itemBuilder: (context, index) => _buildTableRow(currentData[index], index),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> showAddDialog(BuildContext context, String type) async {
  final formKey = GlobalKey<FormState>();

  String username = '';
  String phoneNumber = '';
  String password = '';
  String name = '';
  num classId = 0;
  num parentId = 0;
  num fees = 0;

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add New ${type == "student" ? "Student" : "User"}'),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (type == "student") ...[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    onChanged: (val) => name = val,
                    validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Class ID'),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => classId = num.tryParse(val) ?? 0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Parent ID'),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => parentId = num.tryParse(val) ?? 0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Fees'),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => fees = num.tryParse(val) ?? 0,
                  ),
                ] else ...[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Username'),
                    onChanged: (val) => username = val,
                    validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Phone Number'),
                    onChanged: (val) => phoneNumber = val,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onChanged: (val) => password = val,
                    validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
                ],
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: Text('Add'),
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                bool success = false;
                if (type == "student") {
                  StudentModel newStudent = StudentModel(
                    name: name,
                    classId: classId,
                    parentId: parentId,
                    profilePicture: '',
                    fees: fees,
                    id: 0,
                  );
                  success = await AppServices.studentService.createStudent(newStudent);
                } else {
                  UserRole role;
                  if (type == "parent") {
                    role = UserRole.parent;
                  } else if (type == "teacher") {
                    role = UserRole.teacher;
                  } else {
                    role = UserRole.busMentor;
                  }
                  CreateUserModel newUser = CreateUserModel(
                    username: username,
                    phoneNumber: phoneNumber,
                    password: password,
                  );
                  success = await AppServices.crudService.createUserByRole(newUser, role);
                }
                if (success) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('success.')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to add. Please try again.')),
                  );
                }
              }
            },
          ),
        ],
      );
    },
  );
}*/

//قبل تعديل الخلايا
/*import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:school_managment/core/app_service.dart';
import 'package:shimmer/shimmer.dart';

import '../../model/admin/create_user_model.dart';
import '../../model/admin/user_model.dart';
import '../../model/student_model.dart';
import '../../service/admin/crud_service.dart';
import '../../service/admin/student_service.dart';

class StatCardPainter extends CustomPainter {
  final Color cardColor;
  final Color curveAccentColor;

  StatCardPainter({required this.cardColor, required this.curveAccentColor});

  @override
  void paint(Canvas canvas, Size size) {
    final RRect rRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(15),
    );
    final cardPaint = Paint()..color = cardColor;
    canvas.drawRRect(rRect, cardPaint);

    final wavePaint = Paint()
      ..color = curveAccentColor
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.8);

    path.cubicTo(
      size.width * 0.25, size.height * 0.7,
      size.width * 0.25, size.height * 0.9,
      size.width * 0.5, size.height * 0.8,
    );

    path.cubicTo(
      size.width * 0.75, size.height * 0.7,
      size.width * 0.75, size.height * 0.9,
      size.width, size.height * 0.8,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(covariant StatCardPainter oldDelegate) {
    return oldDelegate.cardColor != cardColor || oldDelegate.curveAccentColor != curveAccentColor;
  }
}

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<dynamic> currentData = [];
  String currentType = "";

  bool isLoading = false;
  bool statsLoading = false;

  int totalStudents = 0, totalParents = 0, totalTeachers = 0, totalBusMentors = 0;

  @override
  void initState() {
    super.initState();
    fetchStats();
  }

  Future<void> fetchStats() async {
    setState(() => statsLoading = true);

    try {
      final stu = await AppServices.studentService.getAllStudent();
      final parents = await AppServices.crudService.getUsersByRole(UserRole.parent);
      final teachers = await AppServices.crudService.getUsersByRole(UserRole.teacher);
      final bus = await AppServices.crudService.getUsersByRole(UserRole.busMentor);

      setState(() {
        totalStudents = stu.length;
        totalParents = parents.length;
        totalTeachers = teachers.length;
        totalBusMentors = bus.length;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() => statsLoading = false);
    }
  }

  Future<void> fetchStudents() async {
    setState(() {
      isLoading = true;
      currentType = "student";
    });
    final students = await AppServices.studentService.getAllStudent();
    setState(() {
      currentData = students;
      isLoading = false;
    });
  }

  Future<void> fetchUsers(UserRole role) async {
    setState(() {
      isLoading = true;
      currentType = role.name;
    });
    final users = await AppServices.crudService.getUsersByRole(role);
    setState(() {
      currentData = users;
      isLoading = false;
    });
  }

  Widget _buildStatCard(String title, int count, Color color, VoidCallback onTap) {
    final Color cardBackgroundColor = color.withOpacity(0.8);
    final Color waveAccentColor = Colors.black.withOpacity(0.1);

    return GestureDetector(
      onTap: onTap,
      child: statsLoading
          ? Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: 120,
          width: 200,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      )
          : Container(
        height: 120,
        width: 200,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: StatCardPainter(
                    cardColor: cardBackgroundColor,
                    curveAccentColor: waveAccentColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white.withOpacity(0.9))),
                    SizedBox(height: 8),
                    Text(count.toString(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildTableHeader() {
    const headerTextStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Color(0xFF6B7280)); // لون رمادي أغمق قليلاً

    if (currentType == "student") {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16), // زيادة الهامش الأفقي
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(bottom: BorderSide(color: Colors.grey.shade300!, width: 1.0)), // خط فاصل سفلي خفيف
        ),
        child: Row(
          children: [
            Expanded(flex: 1, child: Text("ID", style: headerTextStyle)),
            Expanded(flex: 2, child: Text("Name", style: headerTextStyle)),
            Expanded(flex: 2, child: Text("Class ID", style: headerTextStyle)),
            Expanded(flex: 2, child: Text("Parent ID", style: headerTextStyle)),
            Expanded(flex: 1, child: Text("Fees", style: headerTextStyle)),
          ],
        ),
      );
    } else if (["parent", "teacher", "busMentor"].contains(currentType)) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16), // زيادة الهامش الأفقي
        decoration: BoxDecoration(
          color: Colors.transparent, // جعل الخلفية شفافة
          border: Border(bottom: BorderSide(color: Colors.grey.shade300!, width: 1.0)), // خط فاصل سفلي خفيف
        ),
        child: Row(
          children: [
            Expanded(flex: 1, child: Text("ID", style: headerTextStyle)),
            Expanded(flex: 2, child: Text("Username", style: headerTextStyle)),
            Expanded(flex: 2, child: Text("Phone", style: headerTextStyle)),
            Expanded(flex: 1, child: Text("Role", style: headerTextStyle)),
            Expanded(flex: 1, child: Text("Active", style: headerTextStyle)),
          ],
        ),
      );
    } else {
      return Center(child: Text("Select a category to display data."));
    }
  }

  Widget _buildTableRow(dynamic item, int index) {
    // تلوين الصفوف المتناوب ليتناسب مع الصورة
    Color rowColor = index % 2 == 0 ? Colors.white : Color(0xFFF9FAFB); // لون أبيض ولون رمادي فاتح جدًا جداً

    const cellTextStyle = TextStyle(fontSize: 13, color: Color(0xFF4B5563)); // لون رمادي أغمق قليلاً

    if (item is StudentModel) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16), // زيادة الهامش لارتفاع الصف
        color: rowColor,
        child: Row(
          children: [
            Expanded(flex: 1, child: Text(item.id.toString(), style: cellTextStyle)),
            Expanded(flex: 2, child: Text(item.name, style: cellTextStyle)),
            Expanded(flex: 2, child: Text(item.classId.toString(), style: cellTextStyle)),
            Expanded(flex: 2, child: Text(item.parentId.toString(), style: cellTextStyle)),
            Expanded(flex: 1, child: Text(item.fees.toString(), style: cellTextStyle)),
          ],
        ),
      );
    } else if (item is UserModel) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16), // زيادة الهامش لارتفاع الصف
        color: rowColor,
        child: Row(
          children: [
            Expanded(flex: 1, child: Text(item.id.toString(), style: cellTextStyle)),
            Expanded(flex: 2, child: Text(item.username, style: cellTextStyle)),
            Expanded(flex: 2, child: Text(item.phoneNumber, style: cellTextStyle)),
            Expanded(flex: 1, child: Text(item.role, style: cellTextStyle)),
            Expanded(flex: 1, child: Text(item.isActive ? "Yes" : "No", style: cellTextStyle)),
          ],
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _buildSidebar() {
    return Container(
      width: 60,
      color: Color(0xFF90A38A),
      child: Column(
        children: [
          SizedBox(height: 20),
          Icon(Icons.dashboard, color: Colors.white),
          SizedBox(height: 20),
          Icon(Icons.analytics, color: Colors.white),
          SizedBox(height: 20),
          Icon(Icons.inventory, color: Colors.white),
          SizedBox(height: 20),
          Icon(Icons.settings, color: Colors.white),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF9F9F9),
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Good Evening, admin", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Icon(Icons.notifications_none),
                          SizedBox(width: 10),
                          Icon(Icons.account_circle_outlined),
                          SizedBox(width: 10),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),

                  Row(
                    children: [
                      _buildStatCard("Students", totalStudents, Color(0xffA1BF99), fetchStudents),
                      _buildStatCard("Parents", totalParents, Color(0xffFFCF94), () => fetchUsers(UserRole.parent)),
                      _buildStatCard("Teachers", totalTeachers, Color(0xffB898C1), () => fetchUsers(UserRole.teacher)),
                      _buildStatCard("Bus Mentors", totalBusMentors, Color(0xffC19999), () => fetchUsers(UserRole.busMentor)),
                    ],
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 3,
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 850),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Data Table", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  ElevatedButton.icon(
                                    icon: Icon(Icons.add),
                                    label: Text("Add New"),
                                    onPressed: () => showAddDialog(context, currentType),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              // Table Header
                              _buildTableHeader(),
                              // Table Rows
                              Expanded(
                                child: isLoading
                                    ? ListView.builder(
                                  itemCount: 6,
                                  itemBuilder: (_, __) => Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 6),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Row(
                                        children: List.generate(
                                          5,
                                              (_) => Expanded(
                                            child: Container(
                                              height: 20,
                                              margin: EdgeInsets.symmetric(horizontal: 4),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                    : currentData.isEmpty
                                    ? Center(child: Text("No data available"))
                                    : ListView.builder(
                                  itemCount: currentData.length,
                                  itemBuilder: (context, index) => _buildTableRow(currentData[index], index),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}

Future<void> showAddDialog(BuildContext context, String type) async {
  final formKey = GlobalKey<FormState>();

  String username = '';
  String phoneNumber = '';
  String password = '';
  String name = '';
  num classId = 0;
  num parentId = 0;
  num fees = 0;

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add New ${type == "student" ? "Student" : "User"}'),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (type == "student") ...[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    onChanged: (val) => name = val,
                    validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Class ID'),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => classId = num.tryParse(val) ?? 0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Parent ID'),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => parentId = num.tryParse(val) ?? 0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Fees'),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => fees = num.tryParse(val) ?? 0,
                  ),
                ] else ...[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Username'),
                    onChanged: (val) => username = val,
                    validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Phone Number'),
                    onChanged: (val) => phoneNumber = val,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onChanged: (val) => password = val,
                    validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
                ],
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: Text('Add'),
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                bool success = false;
                if (type == "student") {
                  StudentModel newStudent = StudentModel(
                    name: name,
                    classId: classId,
                    parentId: parentId,
                    profilePicture: '',
                    fees: fees,
                    id: 0,
                  );
                  success = await AppServices.studentService.createStudent(newStudent);
                } else {
                  UserRole role;
                  if (type == "parent") {
                    role = UserRole.parent;
                  } else if (type == "teacher") {
                    role = UserRole.teacher;
                  } else {
                    role = UserRole.busMentor;
                  }
                  CreateUserModel newUser = CreateUserModel(
                    username: username,
                    phoneNumber: phoneNumber,
                    password: password,
                  );
                  success = await AppServices.crudService.createUserByRole(newUser, role);
                }
                if (success) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('success.')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to add. Please try again.')),
                  );
                }
              }
            },
          ),
        ],
      );
    },
  );
}
*/
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:school_managment/core/app_service.dart';
import 'package:shimmer/shimmer.dart';

import '../../model/admin/create_user_model.dart';
import '../../model/admin/user_model.dart';
import '../../model/classes_model.dart';
import '../../model/student_model.dart';
import '../../service/admin/crud_service.dart';
import '../../service/admin/student_service.dart';

class StatCardPainter extends CustomPainter {
  final Color cardColor;
  final Color curveAccentColor;

  StatCardPainter({required this.cardColor, required this.curveAccentColor});

  @override
  void paint(Canvas canvas, Size size) {
    final RRect rRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(15),
    );
    final cardPaint = Paint()..color = cardColor;
    canvas.drawRRect(rRect, cardPaint);

    final wavePaint = Paint()
      ..color = curveAccentColor
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height * 0.8);

    path.cubicTo(
      size.width * 0.25, size.height * 0.7,
      size.width * 0.25, size.height * 0.9,
      size.width * 0.5, size.height * 0.8,
    );

    path.cubicTo(
      size.width * 0.75, size.height * 0.7,
      size.width * 0.75, size.height * 0.9,
      size.width, size.height * 0.8,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, wavePaint);
  }

  @override
  bool shouldRepaint(covariant StatCardPainter oldDelegate) {
    return oldDelegate.cardColor != cardColor || oldDelegate.curveAccentColor != curveAccentColor;
  }
}

class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<dynamic> currentData = [];
  List<ClassModel> classesData = [];
  String currentType = "";

  bool isLoading = false;
  bool statsLoading = false;
  bool classesLoading = false;

  int totalStudents = 0, totalParents = 0, totalTeachers = 0, totalBusMentors = 0;

  num? editingStudentId;
  String? editingField;
  final FocusNode _editingFocusNode = FocusNode();
  final TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchStats();
    fetchClasses();
    _editingFocusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _editingFocusNode.removeListener(_handleFocusChange);
    _editingFocusNode.dispose();
    _editingController.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (!_editingFocusNode.hasFocus && editingStudentId != null && editingField != null) {
      _saveEditedValue();
    }
  }

  void _startEditing(num studentId, String fieldName, String initialValue) {
    setState(() {
      editingStudentId = studentId;
      editingField = fieldName;
      _editingController.text = initialValue;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _editingFocusNode.requestFocus();
      _editingController.selection = TextSelection.fromPosition(TextPosition(offset: _editingController.text.length));
    });
  }

  Future<void> _saveEditedValue() async {
    if (editingStudentId == null || editingField == null) return;

    final studentToUpdateIndex = currentData.indexWhere((s) => s is StudentModel && s.id == editingStudentId);
    if (studentToUpdateIndex == -1) return;

    StudentModel student = currentData[studentToUpdateIndex] as StudentModel;
    bool success = false;

    if (editingField == 'fees') {
      final num? newFees = num.tryParse(_editingController.text);
      if (newFees != null) {
        success = await AppServices.studentService.updateStudentFees(student.id, newFees);
        if (success) {
          setState(() {
            currentData[studentToUpdateIndex] = student.copyWith(fees: newFees);
          });
        }
      }
    } else if (editingField == 'class_id') {
      final int? newClassId = int.tryParse(_editingController.text);
      if (newClassId != null) {
        success = await AppServices.studentService.updateStudentClassId(student.id, newClassId);
        if (success) {
          setState(() {
            currentData[studentToUpdateIndex] = student.copyWith(classId: newClassId);
          });
        }
      }
    }

    setState(() {
      editingStudentId = null;
      editingField = null;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Updated successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update.')),
      );
    }
  }

  Future<void> fetchStats() async {
    setState(() => statsLoading = true);

    try {
      final stu = await AppServices.studentService.getAllStudent();
      final parents = await AppServices.crudService.getUsersByRole(UserRole.parent);
      final teachers = await AppServices.crudService.getUsersByRole(UserRole.teacher);
      final bus = await AppServices.crudService.getUsersByRole(UserRole.busMentor);

      setState(() {
        totalStudents = stu.length;
        totalParents = parents.length;
        totalTeachers = teachers.length;
        totalBusMentors = bus.length;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() => statsLoading = false);
    }
  }

  Future<void> fetchStudents() async {
    setState(() {
      isLoading = true;
      currentType = "student";
    });
    final students = await AppServices.studentService.getAllStudent();
    setState(() {
      currentData = students;
      isLoading = false;
    });
  }

  Future<void> fetchUsers(UserRole role) async {
    setState(() {
      isLoading = true;
      currentType = role.name;
    });
    final users = await AppServices.crudService.getUsersByRole(role);
    setState(() {
      currentData = users;
      isLoading = false;
    });
  }
  Future<void> fetchClasses() async {
    setState(() => classesLoading = true);
    try {
      final classes = await AppServices.classService.getAllClass();
      setState(() {
        classesData = classes;
      });
    } catch (e) {
      print("Error fetching classes: $e");
      setState(() {
        classesData = [];
      });
    } finally {
      setState(() => classesLoading = false);
    }
  }

  Widget _buildStatCard(String title, int count, Color color, VoidCallback onTap) {
    final Color cardBackgroundColor = color.withOpacity(0.8);
    final Color waveAccentColor = Colors.black.withOpacity(0.1);

    return GestureDetector(
      onTap: onTap,
      child: statsLoading
          ? Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          height: 120,
          width: 200,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      )
          : Container(
        height: 120,
        width: 200,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: StatCardPainter(
                    cardColor: cardBackgroundColor,
                    curveAccentColor: waveAccentColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white.withOpacity(0.9))),
                    SizedBox(height: 8),
                    Text(count.toString(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    const headerTextStyle = TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Color(0xFF6B7280));

    if (currentType == "student") {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.transparent,

        ),
        child: Row(
          children: [
            Expanded(flex: 1, child: Text("ID", style: headerTextStyle)),
            Expanded(flex: 2, child: Text("Name", style: headerTextStyle)),
            Expanded(flex: 2, child: Text("Class ID", style: headerTextStyle)),
            Expanded(flex: 2, child: Text("Parent ID", style: headerTextStyle)),
            Expanded(flex: 1, child: Text("Fees", style: headerTextStyle)),
          ],
        ),
      );
    } else if (["parent", "teacher", "busMentor"].contains(currentType)) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Row(
          children: [
            Expanded(flex: 1, child: Text("ID", style: headerTextStyle)),
            Expanded(flex: 2, child: Text("Username", style: headerTextStyle)),
            Expanded(flex: 2, child: Text("Phone", style: headerTextStyle)),
            Expanded(flex: 1, child: Text("Role", style: headerTextStyle)),
            Expanded(flex: 1, child: Text("Active", style: headerTextStyle)),
          ],
        ),
      );
    } else {
      return Center(child: Text("Select a category to display data."));
    }
  }

  Widget _buildEditableCell(StudentModel student, String fieldName, String value) {
    bool isEditingThisCell = editingStudentId == student.id && editingField == fieldName;
    const cellTextStyle = TextStyle(fontSize: 13, color: Color(0xFF4B5563));

    return GestureDetector(
      onTap: () => _startEditing(student.id, fieldName, value),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
        child: isEditingThisCell
            ? TextFormField(
          controller: _editingController,
          focusNode: _editingFocusNode,
          keyboardType: fieldName == 'fees' ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.zero,
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
            ),
          ),
          style: cellTextStyle,
          onFieldSubmitted: (newValue) {
            _editingFocusNode.unfocus();
          },
        )
            : Text(value, style: cellTextStyle),
      ),
    );
  }


  Widget _buildTableRow(dynamic item, int index) {

    Color rowColor = Colors.transparent;
    const cellTextStyle = TextStyle(fontSize: 13, color: Color(0xFF4B5563));
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: rowColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200!, width: 1.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text(item.id.toString(), style: cellTextStyle)),
          Expanded(flex: 2, child: Text(item is StudentModel ? item.name : item.username, style: cellTextStyle)),
          if (item is StudentModel) ...[
            Expanded(flex: 2, child: _buildEditableCell(item, 'class_id', item.classId.toString())),
            Expanded(flex: 2, child: Text(item.parentId.toString(), style: cellTextStyle)),
            Expanded(flex: 1, child: _buildEditableCell(item, 'fees', item.fees.toString())),
          ]

          else if (item is UserModel) ...[
            //Expanded(flex: 2, child: Text(item.username, style: cellTextStyle)),
            Expanded(flex: 2, child: Text(item.phoneNumber, style: cellTextStyle)),
            Expanded(flex: 1, child: Text(item.role, style: cellTextStyle)),
            Expanded(flex: 1, child: Text(item.isActive ? "Yes" : "No", style: cellTextStyle)),
          ]
          else ...[
              SizedBox.shrink(),
            ]
        ],
      ),
    );
  }
  Widget _buildSidebar() {
    return Container(
      width: 60,
      color: Color(0xFF90A38A),
      child: Column(
        children: [
          SizedBox(height: 20),
          Icon(Icons.dashboard, color: Colors.white),
          SizedBox(height: 20),
          Icon(Icons.analytics, color: Colors.white),
          SizedBox(height: 20),
          Icon(Icons.inventory, color: Colors.white),
          SizedBox(height: 20),
          Icon(Icons.settings, color: Colors.white),
        ],
      ),
    );
  }
  Widget _buildClassListItem(ClassModel classItem, Color iconColor) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.school, color: iconColor, size: 24), // يمكنك تغيير الأيقونة
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  classItem.name,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  'Teacher ID: ${classItem.teacherId}', // افتراض أن هذا هو الوقت/الوصف
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Text(
            classItem.id.toString(), // عرض الـ ID كـ "عدد الطلاب" أو "رقم الغرفة"
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
  Future<void> _showAddClassDialog(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    String className = '';
    int teacherId = 0;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Class'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Class Name'),
                    onChanged: (val) => className = val,
                    validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Teacher ID'),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => teacherId = int.tryParse(val) ?? 0,
                    validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text('Add'),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  ClassModel newClass = ClassModel(
                    name: className,
                    teacherId: teacherId,
                    id: 0,
                  );
                  bool success = await AppServices.classService.createClass(newClass);
                  if (success) {
                    Navigator.of(context).pop();
                    fetchClasses();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Class added successfully.')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to add class. Please try again.')),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Good Evening, admin", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Icon(Icons.notifications_none),
                          SizedBox(width: 10),
                          Icon(Icons.account_circle_outlined),
                          SizedBox(width: 10),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      _buildStatCard("Students", totalStudents, Color(0xffA1BF99), fetchStudents),
                      _buildStatCard("Parents", totalParents, Color(0xffFFCF94), () => fetchUsers(UserRole.parent)),
                      _buildStatCard("Teachers", totalTeachers, Color(0xffB898C1), () => fetchUsers(UserRole.teacher)),
                      _buildStatCard("Bus Mentors", totalBusMentors, Color(0xffC19999), () => fetchUsers(UserRole.busMentor)),
                    ],
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Card(
                        //color: Color(0xffF3ECE6),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 3,
                        child: Container(
                          constraints: BoxConstraints(maxWidth: 850),
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Data Table", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                  ElevatedButton.icon(
                                    icon: Icon(Icons.add),
                                    label: Text("Add New"),
                                    onPressed: () => showAddDialog(context, currentType),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              _buildTableHeader(),
                              Expanded(
                                child: isLoading
                                    ? ListView.builder(
                                  itemCount: 6,
                                  itemBuilder: (_, __) => Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 6),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      child: Row(
                                        children: List.generate(
                                          5,
                                              (_) => Expanded(
                                            child: Container(
                                              height: 20,
                                              margin: EdgeInsets.symmetric(horizontal: 4),
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                    : currentData.isEmpty
                                    ? Center(child: Text("No data available"))
                                    : ListView.builder(
                                  itemCount: currentData.length,
                                  itemBuilder: (context, index) => _buildTableRow(currentData[index], index),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35.0, right: 20),
            child: Container(
              width: 300,
              height: 600,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xffF3ECE6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Classes List",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Color(0xffAC8685),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).primaryColor.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: Icon(Icons.add, color: Colors.white, size: 20),
                            onPressed: () => _showAddClassDialog(context),
                            padding: EdgeInsets.zero,
                            splashRadius: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: classesLoading
                        ? Center(child: CircularProgressIndicator())
                        : classesData.isEmpty
                        ? Center(child: Text("No classes available."))
                        : ListView.builder(
                      itemCount: classesData.length,
                      itemBuilder: (context, index) {
                        List<Color> iconColors = [
                          Color(0xFF6A5ACD),
                          Color(0xFFF08080),
                          Color(0xFF90EE90),
                          Color(0xFFFFA500),
                          Color(0xFF87CEEB),
                        ];
                        Color currentColor = iconColors[index % iconColors.length];
                        return _buildClassListItem(classesData[index], currentColor);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}

Future<void> showAddDialog(BuildContext context, String type) async {
  final formKey = GlobalKey<FormState>();

  String username = '';
  String phoneNumber = '';
  String password = '';
  String name = '';
  num classId = 0;
  num parentId = 0;
  num fees = 0;

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add New ${type == "student" ? "Student" : "User"}'),
        content: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (type == "student") ...[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    onChanged: (val) => name = val,
                    validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Class ID'),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => classId = num.tryParse(val) ?? 0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Parent ID'),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => parentId = num.tryParse(val) ?? 0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Fees'),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => fees = num.tryParse(val) ?? 0,
                  ),
                ] else ...[
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Username'),
                    onChanged: (val) => username = val,
                    validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Phone Number'),
                    onChanged: (val) => phoneNumber = val,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onChanged: (val) => password = val,
                    validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
                ],
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: Text('Add'),
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                bool success = false;
                if (type == "student") {
                  StudentModel newStudent = StudentModel(
                    name: name,
                    classId: classId,
                    parentId: parentId,
                    profilePicture: '',
                    fees: fees,
                    id: 0,
                  );
                  success = await AppServices.studentService.createStudent(newStudent);
                } else {
                  UserRole role;
                  if (type == "parent") {
                    role = UserRole.parent;
                  } else if (type == "teacher") {
                    role = UserRole.teacher;
                  } else {
                    role = UserRole.busMentor;
                  }
                  CreateUserModel newUser = CreateUserModel(
                    username: username,
                    phoneNumber: phoneNumber,
                    password: password,
                  );
                  success = await AppServices.crudService.createUserByRole(newUser, role);
                }
                if (success) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('success.')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to add. Please try again.')),
                  );
                }
              }
            },
          ),
        ],
      );
    },
  );
}
