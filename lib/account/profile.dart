
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../hotel/secreens/base_page.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  var users = [];

  CollectionReference refUser = FirebaseFirestore.instance.collection("users");

  getAllUser() async {
    await refUser.where("email", isEqualTo: user.email).get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          users.add(element.data());
          print(users);
        });
      });
    });
  }

  @override
  void initState() {
    getUser();
    getAllUser();
    super.initState();
  }

  @override
  //bool isLoggedIn = false;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => BasePage()),
                        (route) => false,
                  );
                  print("exit");
                },
                icon: Icon(Icons.exit_to_app))
          ],
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Color(0xff1baedf)),
          title: Text("My Profile",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
              ))),
      body: Column(
        children: [
          Container(
            // color: Color(0xff1baedf),
            width: 360,
            height: 180,
            child: Text(
              "Welcome in our app",
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 35, color: Color.fromARGB(255, 0, 0, 0)),
            ),
            alignment: Alignment.center,

            decoration: BoxDecoration(
                color: Color(0xff1baedf),
                borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(100),
                    bottomStart: Radius.circular(100))),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Form(
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "${users[0]['username']}",
                    prefixIcon: Icon(Icons.person),
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 1))),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Form(
              child: TextFormField(
                decoration: InputDecoration(
                    hintText: "${users[0]['email']}",
                    prefixIcon: Icon(Icons.email),
                    border:
                        OutlineInputBorder(borderSide: BorderSide(width: 1))),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(25),
          ),
          Container(
            // color: Color(0xff1baedf),
            width: 360,
            height: 170,

            decoration: BoxDecoration(
                color: Color(0xff1baedf),
                borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(100),
                    topStart: Radius.circular(100))),
          ),
        ],
      ),
    );
  }
}
