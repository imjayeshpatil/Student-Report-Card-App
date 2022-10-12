import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StudentSearch extends StatefulWidget {
  const StudentSearch({Key? key}) : super(key: key);

  @override
  State<StudentSearch> createState() => _StudentSearchState();
}

class _StudentSearchState extends State<StudentSearch> {
  List? allUserList;
  bool loadingCicular = false;
  bool isFirst = false;
  String aclass = "";
  String grade = "";
  final TextEditingController searchController = TextEditingController();

  Future<void> getData() async {
    try {
      var collection = FirebaseFirestore.instance
          .collection('StudentDetails')
          .where('rollno', isEqualTo: searchController.text.toString());
      var querySnapshots = await collection.get();

      setState(() {
        loadingCicular = false;
        allUserList = querySnapshots.docs;
      });

      if (allUserList == null || allUserList!.length <= 0) {
        showSnackBar(context, "No Student found");
      } else {
        print("Data: " + allUserList![0]['name'].toString());
      }
    } on FirebaseException catch (e) {
      print(e.code);
    }
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Search Student Record"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Search Student',
                prefixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    loadingCicular = true;
                    isFirst = true;
                    setState(() {
                      getData();
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 10),
            loadingCicular
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  )
                : allUserList != null && allUserList!.length > 0
                    ? Card(
                        elevation: 1,
                        child: ListTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "Roll No: " +
                                      allUserList![0]['rollno'].toString(),
                                  style: TextStyle(fontSize: 18)),
                              SizedBox(height: 5),
                              Text("Student Name: " + allUserList![0]['name'],
                                  style: TextStyle(fontSize: 18)),
                              SizedBox(height: 5),
                              Text(
                                  "Branch: " +
                                      allUserList![0]['branch'].toString(),
                                  style: TextStyle(fontSize: 18)),
                              SizedBox(height: 5),
                              Text(
                                  "Email: " +
                                      allUserList![0]['email'].toString(),
                                  style: TextStyle(fontSize: 18)),
                              SizedBox(height: 5),
                              Text(
                                  "Mobile No: " +
                                      allUserList![0]['mobileno'].toString(),
                                  style: TextStyle(fontSize: 18)),
                              SizedBox(height: 5),
                              Text(
                                  "Gender: " +
                                      allUserList![0]['gender'].toString(),
                                  style: TextStyle(fontSize: 18)),
                              SizedBox(height: 5),
                              Text(
                                  "Semester: " +
                                      allUserList![0]['semester'].toString(),
                                  style: TextStyle(fontSize: 18)),
                              SizedBox(height: 5),
                              Text(
                                  "Year: " + allUserList![0]['year'].toString(),
                                  style: TextStyle(fontSize: 18)),
                              SizedBox(height: 5),
                              Text(
                                  "Address: " +
                                      allUserList![0]['address'].toString(),
                                  style: TextStyle(fontSize: 18)),
                              SizedBox(height: 5),
                              Text(
                                  "Sub 1 Marks: " +
                                      allUserList![0]['subject1'].toString(),
                                  style: TextStyle(fontSize: 18)),
                              SizedBox(height: 5),
                              Text(
                                  "Sub 2 Marks: " +
                                      allUserList![0]['subject2'].toString(),
                                  style: TextStyle(fontSize: 18)),
                              SizedBox(height: 5),
                              Text(
                                  "Sub 3 Marks: " +
                                      allUserList![0]['subject3'].toString(),
                                  style: TextStyle(fontSize: 18)),
                              SizedBox(height: 5),
                              Text(
                                  "Sub 4 Marks: " +
                                      allUserList![0]['subject4'].toString(),
                                  style: TextStyle(fontSize: 18)),
                              SizedBox(height: 5),
                              Text(
                                  "Sub 5 Marks: " +
                                      allUserList![0]['subject5'].toString(),
                                  style: TextStyle(fontSize: 18)),
                              SizedBox(height: 5),
                              Text("Total Marks: " + calculate_Marks(0),
                                  style: TextStyle(fontSize: 18)),
                              SizedBox(height: 5),
                              Text(
                                  "Total Percentage: " +
                                      calculate_Percentage(0) +
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
                          onTap: () {},
                        ),
                      )
                    : isFirst
                        ? Center(
                            child: Container(
                                child: Text("No Student Record Found")))
                        : Container(),
          ],
        ),
      ),
    );
  }
}
