import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentList extends StatefulWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  List? allUserList;
  bool loadingCicular = true;
  String aclass = "";
  String grade = "";

  Future<List?> getData() async {
    try {
      var collection = FirebaseFirestore.instance.collection('StudentDetails');
      var querySnapshots = await collection.get();

      setState(() {
        loadingCicular = false;
        allUserList = querySnapshots.docs;
      });

      if (allUserList == null || allUserList!.length <= 0) {
        showSnackBar(context, "No Student found");
      }
    } on FirebaseException catch (e) {
      print(e.code);
    }

    return allUserList;
  }

  showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  String calculate_Percentage(int index) {
    double total_Marks =
        double.parse(allUserList![index]['subject1'].toString()) +
            double.parse(allUserList![index]['subject2'].toString()) +
            double.parse(allUserList![index]['subject3'].toString()) +
            double.parse(allUserList![index]['subject4'].toString()) +
            double.parse(allUserList![index]['subject5'].toString());
    double total_Percentage = (total_Marks / 500) * 100;
    if (total_Percentage < 50) {
      aclass = "Second Class";
      grade = "C";
      //second class
    } else if (total_Percentage >= 50 && total_Percentage < 65) {
      //first class
      aclass = "First Class";
      grade = "B";
    } else if (total_Percentage >= 65) {
      //distinction
      aclass = "Distinction";
      grade = "A";
    }
    return total_Percentage.toString();
  }

  String calculate_Marks(int index) {
    double total_Marks =
        double.parse(allUserList![index]['subject1'].toString()) +
            double.parse(allUserList![index]['subject2'].toString()) +
            double.parse(allUserList![index]['subject3'].toString()) +
            double.parse(allUserList![index]['subject4'].toString()) +
            double.parse(allUserList![index]['subject5'].toString());
    return total_Marks.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Student Record"),
      ),
      body: loadingCicular
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : ListView.builder(
              itemCount: allUserList!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Column(
                    children: [
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: ListTile(
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Roll No: " +
                                        allUserList![index]['rollno']
                                            .toString(),
                                    style: TextStyle(fontSize: 18)),
                                SizedBox(height: 5),
                                Text(
                                    "Student Name: " +
                                        allUserList![index]['name'],
                                    style: TextStyle(fontSize: 18)),
                                SizedBox(height: 5),
                                Text(
                                    "Branch: " +
                                        allUserList![index]['branch']
                                            .toString(),
                                    style: TextStyle(fontSize: 18)),
                                SizedBox(height: 5),
                                Text(
                                    "Email: " +
                                        allUserList![index]['email'].toString(),
                                    style: TextStyle(fontSize: 18)),
                                SizedBox(height: 5),
                                Text(
                                    "Mobile No: " +
                                        allUserList![index]['mobileno']
                                            .toString(),
                                    style: TextStyle(fontSize: 18)),
                                SizedBox(height: 5),
                                Text(
                                    "Gender: " +
                                        allUserList![index]['gender']
                                            .toString(),
                                    style: TextStyle(fontSize: 18)),
                                SizedBox(height: 5),
                                Text(
                                    "Semester: " +
                                        allUserList![index]['semester']
                                            .toString(),
                                    style: TextStyle(fontSize: 18)),
                                SizedBox(height: 5),
                                Text(
                                    "Year: " +
                                        allUserList![index]['year'].toString(),
                                    style: TextStyle(fontSize: 18)),
                                SizedBox(height: 5),
                                Text(
                                    "Address: " +
                                        allUserList![index]['address']
                                            .toString(),
                                    style: TextStyle(fontSize: 18)),
                                SizedBox(height: 5),
                                Text(
                                    "Sub 1 Marks: " +
                                        allUserList![index]['subject1']
                                            .toString(),
                                    style: TextStyle(fontSize: 18)),
                                SizedBox(height: 5),
                                Text(
                                    "Sub 2 Marks: " +
                                        allUserList![index]['subject2']
                                            .toString(),
                                    style: TextStyle(fontSize: 18)),
                                SizedBox(height: 5),
                                Text(
                                    "Sub 3 Marks: " +
                                        allUserList![index]['subject3']
                                            .toString(),
                                    style: TextStyle(fontSize: 18)),
                                SizedBox(height: 5),
                                Text(
                                    "Sub 4 Marks: " +
                                        allUserList![index]['subject4']
                                            .toString(),
                                    style: TextStyle(fontSize: 18)),
                                SizedBox(height: 5),
                                Text(
                                    "Sub 5 Marks: " +
                                        allUserList![index]['subject5']
                                            .toString(),
                                    style: TextStyle(fontSize: 18)),
                                SizedBox(height: 5),
                                Text("Total Marks: " + calculate_Marks(index),
                                    style: TextStyle(fontSize: 18)),
                                SizedBox(height: 5),
                                Text(
                                    "Total Percentage: " +
                                        calculate_Percentage(index) +
                                        "%",
                                    style: TextStyle(fontSize: 18)),
                                SizedBox(height: 5),
                                Text("Grade: " + grade.toString(),
                                    style: TextStyle(fontSize: 18)),
                                SizedBox(height: 5),
                                Text("Class: " + aclass.toString(),
                                    style: TextStyle(fontSize: 18)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
