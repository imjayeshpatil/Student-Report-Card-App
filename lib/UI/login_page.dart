import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userNameController = TextEditingController();
  final _passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List? adminLogin;
  bool loadingCicular = true;
  //final TextEditingController passwordController = TextEditingController();

  Future<void> validatePassword() async {
    try {
      if (_userNameController.text.toString().isEmpty ||
          _userNameController.text.toString() != "admin") {
        showSnackBar(context, "Wrong User Name");
        return;
      }

      var collection = FirebaseFirestore.instance
          .collection('Admin')
          .where('password', isEqualTo: _passController.text.toString());
      var querySnapshots = await collection.get();
      adminLogin = querySnapshots.docs;

      if (adminLogin == null || adminLogin!.isEmpty) {
        showSnackBar(context, "Wrong Password");
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
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
    //validatePassword();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Record"),
      ),
      body: Column(
        children: <Widget>[
          body(),
        ],
      ),
    );
  }

  Widget body() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(
              height: 40.0,
            ),
            Text(
              "Please Enter Details",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            TextFormField(
              controller: _userNameController,
              // validator: (value) {
              //   if (value?.isEmpty == null || value!.isEmpty) {
              //     return "Enter mobile no";
              //   } else if (value.length <= 10) {
              //     return "Enter 10 digit mobile no";
              //   }
              // },
              decoration: InputDecoration(
                  hintText: "Username", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextFormField(
              obscureText: true,
              controller: _passController,
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return "Enter valid password";
              //   }
              // },
              decoration: InputDecoration(
                  hintText: "Password", border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  validatePassword();
                });
              },
              child: Text(
                "Login",
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
