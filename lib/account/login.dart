import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking/account/payment.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../commen/theme/light_color_schema.dart';
import '../component/alert.dart';
import '../hotel/secreens/base_page.dart';
import 'Signup.dart';

class Login extends StatefulWidget {
  Login({Key? key, this.total, this.con}) : super(key: key);
  int? total;
  bool? con;

  @override
  State<Login> createState() => _LoginState();
}

var Uid;

class _LoginState extends State<Login> {
  late UserCredential userCredential;
  var mypassword, myemail;

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  logIn() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        showLoading(context);
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: myemail, password: mypassword);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("No user found for that email"))
            ..show();
        } else if (e.code == 'wrong-password') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("Wrong password provided for that user"))
            ..show();
        }
      }
    } else {
      print("Not Vaild");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: lightColorScheme.primary,
          title: Text(
            "Login",
            style: TextStyle(fontSize: 25),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => BasePage()),
                      (route) => false,
                );
              },
              icon: Icon(
                Icons.arrow_back_outlined,
              ))),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(top: 20),
            child: Form(
                key: formstate,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (val) {
                        myemail = val;
                        // منشان يحفظ المعلومات المدخلة
                      },
                      validator: (val) {
                        if (val!.length > 100) {
                          return "Email can't to be larger than 100 letter";
                        }
                        if (val.length < 2) {
                          return "Email can't to be less than 2 letter";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onSaved: (val) {
                        mypassword = val;
                      },
                      validator: (val) {
                        if (val!.length > 100) {
                          return "Password can't to be larger than 100 letter";
                        }
                        if (val.length < 4) {
                          return "Password can't to be less than 4 letter";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.password_rounded),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1))),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Text(
                            "If you haven't account",
                            style: TextStyle(
                              color: lightColorScheme.primary,
                            ),
                          ),
                          TextButton(
                              child: Text(
                                " Sign up",
                                style: TextStyle(color: Color(0xffe63946)),
                              ),
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return SignUp(
                                    total1: widget.total,
                                    con: widget.con,
                                  );
                                }));
                              })
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: lightColorScheme.surfaceTint,
                        ),
                        onPressed: () async {
                          var user = await logIn();
                          if (user != null) {
                            widget.con == true
                                ? Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      BasePage()),
                                  (route) => false,
                            )
                                : Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return PaymentSelectionPage(con: false,);
                            }));
                          }
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
