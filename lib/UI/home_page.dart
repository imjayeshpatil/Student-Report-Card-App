import 'package:flutter/material.dart';
import 'package:student_report/UI/student_list.dart';
import 'package:student_report/UI/student_search.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Record"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 90, top: 100),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentList(),
                    ));
              },
              child: Text(
                "All Student Record",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(minimumSize: Size(150, 40)),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StudentSearch(),
                    ));
              },
              child: Text(
                "Search by Student",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
              ),
              style: ElevatedButton.styleFrom(minimumSize: Size(150, 40)),
            ),
          ],
        ),
      ),
    );
  }
}
