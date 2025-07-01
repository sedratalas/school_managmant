// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'package:school_managment/core/app_service.dart';
// import 'package:school_managment/model/admin/create_user_model.dart';
// import 'package:school_managment/model/admin/user_model.dart';
// import 'package:school_managment/model/classes_model.dart';
// import 'package:school_managment/model/student_model.dart';
// import 'package:school_managment/service/admin/crud_service.dart';
// import 'package:school_managment/service/admin/student_service.dart';
//
// import '../../bloc/user_card/user_card_bloc.dart';
// import '../../bloc/user_card/user_card_event.dart';
// import '../../bloc/user_card/user_card_state.dart';
// import '../../widgets/classes_list.dart';
// import '../../widgets/dashboard_slider.dart';
// import '../../widgets/data_table.dart';
// import '../../widgets/star_card.dart';
//
//
//
//
// class DashboardPage extends StatefulWidget {
//   @override
//   State<DashboardPage> createState() => _DashboardPageState();
// }
//
// class _DashboardPageState extends State<DashboardPage> {
//   List<dynamic> currentData = [];
//   List<ClassModel> classesData = [];
//   String currentType = "";
//
//   bool isLoading = false;
//   bool classesLoading = false;
//
//   num? editingStudentId;
//   String? editingField;
//   final FocusNode _editingFocusNode = FocusNode();
//   final TextEditingController _editingController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<UsersCardBloc>().add(FetchUsersCardStats());
//     fetchClasses();
//     _editingFocusNode.addListener(_handleFocusChange);
//   }
//
//   @override
//   void dispose() {
//     _editingFocusNode.removeListener(_handleFocusChange);
//     _editingFocusNode.dispose();
//     _editingController.dispose();
//     super.dispose();
//   }
//
//   void _handleFocusChange() {
//     if (!_editingFocusNode.hasFocus && editingStudentId != null && editingField != null) {
//       _saveEditedValue();
//     }
//   }
//
//   void _startEditing(num studentId, String fieldName, String initialValue) {
//     setState(() {
//       editingStudentId = studentId;
//       editingField = fieldName;
//       _editingController.text = initialValue;
//     });
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _editingFocusNode.requestFocus();
//       _editingController.selection = TextSelection.fromPosition(TextPosition(offset: _editingController.text.length));
//     });
//   }
//
//   Future<void> _saveEditedValue() async {
//     if (editingStudentId == null || editingField == null) return;
//
//     final studentToUpdateIndex = currentData.indexWhere((s) => s is StudentModel && s.id == editingStudentId);
//     if (studentToUpdateIndex == -1) return;
//
//     StudentModel student = currentData[studentToUpdateIndex] as StudentModel;
//     bool success = false;
//
//     if (editingField == 'fees') {
//       final num? newFees = num.tryParse(_editingController.text);
//       if (newFees != null) {
//         success = await AppServices.studentService.updateStudentFees(student.id, newFees);
//         if (success) {
//           setState(() {
//             currentData[studentToUpdateIndex] = student.copyWith(fees: newFees);
//           });
//         }
//       }
//     } else if (editingField == 'class_id') {
//       final int? newClassId = int.tryParse(_editingController.text);
//       if (newClassId != null) {
//         success = await AppServices.studentService.updateStudentClassId(student.id, newClassId);
//         if (success) {
//           setState(() {
//             currentData[studentToUpdateIndex] = student.copyWith(classId: newClassId);
//           });
//         }
//       }
//     }
//
//     setState(() {
//       editingStudentId = null;
//       editingField = null;
//     });
//
//     if (success) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Updated successfully!')),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to update.')),
//       );
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
//   Future<void> fetchClasses() async {
//     setState(() => classesLoading = true);
//     try {
//       final classes = await AppServices.classService.getAllClass();
//       setState(() {
//         classesData = classes;
//       });
//     } catch (e) {
//       print("Error fetching classes: $e");
//       setState(() {
//         classesData = [];
//       });
//     } finally {
//       setState(() => classesLoading = false);
//     }
//   }
//
//   Future<void> _showAddClassDialog(BuildContext context) async {
//     final formKey = GlobalKey<FormState>();
//     String className = '';
//     int teacherId = 0;
//
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text('Add New Class'),
//           content: SingleChildScrollView(
//             child: Form(
//               key: formKey,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextFormField(
//                     decoration: const InputDecoration(labelText: 'Class Name'),
//                     onChanged: (val) => className = val,
//                     validator: (val) => val == null || val.isEmpty ? 'Required' : null,
//                   ),
//                   TextFormField(
//                     decoration: const InputDecoration(labelText: 'Teacher ID'),
//                     keyboardType: TextInputType.number,
//                     onChanged: (val) => teacherId = int.tryParse(val) ?? 0,
//                     validator: (val) => val == null || val.isEmpty ? 'Required' : null,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//             ElevatedButton(
//               child: const Text('Add'),
//               onPressed: () async {
//                 if (formKey.currentState!.validate()) {
//                   ClassModel newClass = ClassModel(
//                     name: className,
//                     teacherId: teacherId,
//                     id: 0,
//                   );
//                   bool success = await AppServices.classService.createClass(newClass);
//                   if (success) {
//                     Navigator.of(context).pop();
//                     fetchClasses();
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Class added successfully.')),
//                     );
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Failed to add class. Please try again.')),
//                     );
//                   }
//                 }
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF1F3F0),
//       body: Row(
//         children: [
//           const DashboardSidebar(),
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: const [
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
//                   const SizedBox(height: 16),
//                   BlocBuilder<UsersCardBloc, UsersCardState>(
//                     builder: (context, state) {
//                       int students = 0;
//                       int parents = 0;
//                       int teachers = 0;
//                       int busMentors = 0;
//                       bool loading = true;
//
//                       if (state is UsersCardLoaded) {
//                         students = state.totalStudents;
//                         parents = state.totalParents;
//                         teachers = state.totalTeachers;
//                         busMentors = state.totalBusMentors;
//                         loading = false;
//                       } else if (state is UsersCardError) {
//                         print("UsersCard Error: ${state.message}");
//                         loading = false;
//                       }
//
//                       return Row(
//                         children: [
//                           StatCardWidget(
//                             title: "Students",
//                             count: students,
//                             color: const Color(0xffA1BF99),
//                             onTap: fetchStudents,
//                             isLoading: loading,
//                           ),
//                           StatCardWidget(
//                             title: "Parents",
//                             count: parents,
//                             color: const Color(0xffFFCF94),
//                             onTap: () => fetchUsers(UserRole.parent),
//                             isLoading: loading,
//                           ),
//                           StatCardWidget(
//                             title: "Teachers",
//                             count: teachers,
//                             color: const Color(0xffB898C1),
//                             onTap: () => fetchUsers(UserRole.teacher),
//                             isLoading: loading,
//                           ),
//                           StatCardWidget(
//                             title: "Bus Mentors",
//                             count: busMentors,
//                             color: const Color(0xffC19999),
//                             onTap: () => fetchUsers(UserRole.busMentor),
//                             isLoading: loading,
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                   const SizedBox(height: 16),
//                   Expanded(
//                     child: Align(
//                       alignment: Alignment.topLeft,
//                       child: DataTableSection(
//                         currentData: currentData,
//                         isLoading: isLoading,
//                         currentType: currentType,
//                         editingStudentId: editingStudentId,
//                         editingField: editingField,
//                         editingFocusNode: _editingFocusNode,
//                         editingController: _editingController,
//                         onStartEditing: _startEditing,
//                         onSaveEditedValue: _saveEditedValue,
//                         onAddPressed: showAddDialog,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           ClassesListSection(
//             classesData: classesData,
//             classesLoading: classesLoading,
//             onAddClassPressed: () => _showAddClassDialog(context),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
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
//                     decoration: const InputDecoration(labelText: 'Name'),
//                     onChanged: (val) => name = val,
//                     validator: (val) => val == null || val.isEmpty ? 'Required' : null,
//                   ),
//                   TextFormField(
//                     decoration: const InputDecoration(labelText: 'Class ID'),
//                     keyboardType: TextInputType.number,
//                     onChanged: (val) => classId = num.tryParse(val) ?? 0,
//                   ),
//                   TextFormField(
//                     decoration: const InputDecoration(labelText: 'Parent ID'),
//                     keyboardType: TextInputType.number,
//                     onChanged: (val) => parentId = num.tryParse(val) ?? 0,
//                   ),
//                   TextFormField(
//                     decoration: const InputDecoration(labelText: 'Fees'),
//                     keyboardType: TextInputType.number,
//                     onChanged: (val) => fees = num.tryParse(val) ?? 0,
//                   ),
//                 ] else ...[
//                   TextFormField(
//                     decoration: const InputDecoration(labelText: 'Username'),
//                     onChanged: (val) => username = val,
//                     validator: (val) => val == null || val.isEmpty ? 'Required' : null,
//                   ),
//                   TextFormField(
//                     decoration: const InputDecoration(labelText: 'Phone Number'),
//                     onChanged: (val) => phoneNumber = val,
//                   ),
//                   TextFormField(
//                     decoration: const InputDecoration(labelText: 'Password'),
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
//             child: const Text('Cancel'),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           ElevatedButton(
//             child: const Text('Add'),
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
//                     const SnackBar(content: Text('success.')),
//                   );
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Failed to add. Please try again.')),
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
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:school_managment/core/app_service.dart';
import 'package:school_managment/model/admin/create_user_model.dart';
import 'package:school_managment/model/admin/user_model.dart';
import 'package:school_managment/model/classes_model.dart';
import 'package:school_managment/model/student_model.dart';
import 'package:school_managment/service/admin/crud_service.dart';
import 'package:school_managment/service/admin/student_service.dart';

import '../../bloc/classes/classes_bloc.dart';
import '../../bloc/classes/classes_event.dart';
import '../../bloc/classes/classes_state.dart';
import '../../bloc/data_table_management/data_table_event.dart';
import '../../bloc/data_table_management/data_table_state.dart';
import '../../bloc/user_card/user_card_bloc.dart';
import '../../bloc/user_card/user_card_event.dart';
import '../../bloc/user_card/user_card_state.dart';
import '../../widgets/classes_list.dart';
import '../../widgets/dashboard_slider.dart';
import '../../widgets/data_table.dart';
import '../../widgets/star_card.dart';


import 'package:school_managment/bloc/data_table_management/data_table_bloc.dart';


class DashboardPage extends StatefulWidget {
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  num? editingStudentId;
  String? editingField;
  final FocusNode _editingFocusNode = FocusNode();
  final TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<UsersCardBloc>().add(FetchUsersCardStats());
    context.read<ClassesBloc>().add(FetchClasses());
    context.read<DataTableBloc>().add(FetchDataTable(dataType: "student"));
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
      context.read<DataTableBloc>().add(
        UpdateStudentField(
          studentId: editingStudentId!,
          fieldName: editingField!,
          newValue: _editingController.text,
        ),
      );
      setState(() {
        editingStudentId = null;
        editingField = null;
      });
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

  Future<void> _showAddClassDialog(BuildContext context) async {
    final formKey = GlobalKey<FormState>();
    String className = '';
    int teacherId = 0;

    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Add New Class'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Class Name'),
                    onChanged: (val) => className = val,
                    validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Teacher ID'),
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
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  ClassModel newClass = ClassModel(
                    name: className,
                    teacherId: teacherId,
                    id: 0,
                  );
                  context.read<ClassesBloc>().add(AddClass(newClass: newClass));
                  Navigator.of(dialogContext).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAddEntryDialog(BuildContext context, String type) async {
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
      builder: (BuildContext dialogContext) {
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
                      decoration: const InputDecoration(labelText: 'Name'),
                      onChanged: (val) => name = val,
                      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Class ID'),
                      keyboardType: TextInputType.number,
                      onChanged: (val) => classId = num.tryParse(val) ?? 0,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Parent ID'),
                      keyboardType: TextInputType.number,
                      onChanged: (val) => parentId = num.tryParse(val) ?? 0,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Fees'),
                      keyboardType: TextInputType.number,
                      onChanged: (val) => fees = num.tryParse(val) ?? 0,
                    ),
                  ] else ...[
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Username'),
                      onChanged: (val) => username = val,
                      validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Phone Number'),
                      onChanged: (val) => phoneNumber = val,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Password'),
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
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  if (type == "student") {
                    StudentModel newStudent = StudentModel(
                      name: name,
                      classId: classId,
                      parentId: parentId,
                      profilePicture: '',
                      fees: fees,
                      id: 0,
                    );
                    context.read<DataTableBloc>().add(
                      AddNewEntry(entryType: type, studentData: newStudent),
                    );
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
                    context.read<DataTableBloc>().add(
                      AddNewEntry(entryType: type, userData: newUser, userRole: role),
                    );
                  }
                  Navigator.of(dialogContext).pop();
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
      backgroundColor: const Color(0xFFF1F3F0),
      body: Row(
        children: [
          const DashboardSidebar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
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
                  const SizedBox(height: 16),
                  BlocBuilder<UsersCardBloc, UsersCardState>(
                    builder: (context, state) {
                      int students = 0;
                      int parents = 0;
                      int teachers = 0;
                      int busMentors = 0;
                      bool loading = true;

                      if (state is UsersCardLoaded) {
                        students = state.totalStudents;
                        parents = state.totalParents;
                        teachers = state.totalTeachers;
                        busMentors = state.totalBusMentors;
                        loading = false;
                      } else if (state is UsersCardError) {
                        print("UsersCard Error: ${state.message}");
                        loading = false;
                      }

                      return Row(
                        children: [
                          StatCardWidget(
                            title: "Students",
                            count: students,
                            color: const Color(0xffA1BF99),
                            onTap: () => context.read<DataTableBloc>().add(FetchDataTable(dataType: "student")),
                            isLoading: loading,
                          ),
                          StatCardWidget(
                            title: "Parents",
                            count: parents,
                            color: const Color(0xffFFCF94),
                            onTap: () => context.read<DataTableBloc>().add(FetchDataTable(dataType: UserRole.parent.name)),
                            isLoading: loading,
                          ),
                          StatCardWidget(
                            title: "Teachers",
                            count: teachers,
                            color: const Color(0xffB898C1),
                            onTap: () => context.read<DataTableBloc>().add(FetchDataTable(dataType: UserRole.teacher.name)),
                            isLoading: loading,
                          ),
                          StatCardWidget(
                            title: "Bus Mentors",
                            count: busMentors,
                            color: const Color(0xffC19999),
                            onTap: () => context.read<DataTableBloc>().add(FetchDataTable(dataType: UserRole.busMentor.name)),
                            isLoading: loading,
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: BlocConsumer<DataTableBloc, DataTableState>(
                        listener: (context, state) {
                          if (state is DataUpdateSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          } else if (state is DataUpdateFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          } else if (state is DataAddSuccess) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          } else if (state is DataAddFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          } else if (state is DataTableError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            );
                          }
                        },
                        builder: (context, state) {
                          List<dynamic> data = [];
                          bool loading = true;
                          String type = "student";

                          if (state is DataTableLoaded) {
                            data = state.data;
                            loading = false;
                            type = state.currentType;
                          } else if (state is DataTableLoading) {
                            loading = true;
                            type = state.currentType;
                          } else if (state is DataTableError) {
                            loading = false;
                            data = [];
                            type = state.currentType;
                          } else if (state is DataUpdating) {
                            data = state.currentData;
                            loading = true;
                            type = state.currentType;
                          } else if (state is DataUpdateSuccess) {
                            data = state.updatedData;
                            loading = false;
                            type = state.currentType;
                          } else if (state is DataUpdateFailure) {
                            data = state.currentData;
                            loading = false;
                            type = state.currentType;
                          } else if (state is DataAdding) {
                            loading = true;
                            type = state.currentType;
                          } else if (state is DataAddSuccess) {
                            loading = false;
                            type = state.currentType;
                          } else if (state is DataAddFailure) {
                            loading = false;
                            type = state.currentType;
                          }

                          return DataTableSection(
                            currentData: data,
                            isLoading: loading,
                            currentType: type,
                            editingStudentId: editingStudentId,
                            editingField: editingField,
                            editingFocusNode: _editingFocusNode,
                            editingController: _editingController,
                            onStartEditing: _startEditing,
                            onSaveEditedValue: () {
                              if (editingStudentId != null && editingField != null) {
                                context.read<DataTableBloc>().add(
                                  UpdateStudentField(
                                    studentId: editingStudentId!,
                                    fieldName: editingField!,
                                    newValue: _editingController.text,
                                  ),
                                );
                                setState(() {
                                  editingStudentId = null;
                                  editingField = null;
                                });
                              }
                            },
                            onAddPressed: _showAddEntryDialog,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocConsumer<ClassesBloc, ClassesState>(
            listener: (context, state) {
              if (state is ClassAddedSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Class added successfully.')),
                );
              } else if (state is ClassAddFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to add class: ${state.message}')),
                );
              }
            },
            builder: (context, state) {
              List<ClassModel> classes = [];
              bool loading = true;

              if (state is ClassesLoaded) {
                classes = state.classes;
                loading = false;
              } else if (state is ClassesError) {
                print("Classes Error: ${state.message}");
                loading = false;
              } else if (state is ClassAdding) {
                loading = true;
              }

              return ClassesListSection(
                classesData: classes,
                classesLoading: loading,
                onAddClassPressed: () => _showAddClassDialog(context),
              );
            },
          ),
        ],
      ),
    );
  }
}
