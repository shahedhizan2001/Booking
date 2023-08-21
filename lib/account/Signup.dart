import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:booking/account/payment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../commen/theme/light_color_schema.dart';
import '../component/alert.dart';
import '../hotel/secreens/base_page.dart';
import 'login.dart';


class SignUp extends StatefulWidget {
  SignUp({Key? key,this.total1, this.con}) : super(key: key);
  int? total1;
  bool? con;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var myusername, mypassword, myemail;

  GlobalKey<FormState> formstate = new GlobalKey<FormState>();


  RegExp regex1 = RegExp(r"^[a-zA-Z0-9.]+@gmail\.com$");
  RegExp regex2 = RegExp("[a-zA-Z]+");


  signUp() async {
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        showLoading(context);
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: myemail, password: mypassword);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("Password is to weak"))
            ..show();
        } else if (e.code == 'email-already-in-use') {
          Navigator.of(context).pop();
          AwesomeDialog(
              context: context,
              title: "Error",
              body: Text("The account already exists for that email"))
            ..show();
        }
      } catch (e) {
        print(e);
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor:  lightColorScheme.primary,
        title: Text(
          "Signup",
          style: TextStyle(fontSize: 25),
        ),
      ),
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
                        myusername = val;
                      },
                      validator: (val) {
                        if (val!.length > 100) {
                          return "usename can't to be larger than 100 latter";
                        }
                        if (val.length < 2) {
                          return "username can't to be less than 2 letter";
                        }
                        if(regex2.hasMatch(val.toString()) == false){
                          return "The name must contain letters";
                        }

                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Username",
                          prefixIcon: Icon(Icons.person),
                          border:
                          OutlineInputBorder(borderSide: BorderSide(width: 1))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onSaved: (val) {
                        myemail = val;
                      },
                      validator: (val) {
                        if (val!.length > 100) {
                          return "Email can't to be larger than 100 latter";
                        }
                        if (val.length < 2) {
                          return "Email can't to be less than 2 letter";
                        }
                        if(regex1.hasMatch(val.toString()) == false){
                          return "Email must contain @gmail.com ";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email),
                          border:
                          OutlineInputBorder(borderSide: BorderSide(width: 1))),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      onSaved: (val) {
                        mypassword = val;
                      },
                      validator: (val) {
                        if (val!.length > 100) {
                          return "Password can't to be larger than 100 latter";
                        }
                        if (val.length < 8) {
                          return "Password can't to be less than 8 letter";
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.password_rounded),
                          border:
                          OutlineInputBorder(borderSide: BorderSide(width: 1))),

                    ),
                    Container(
                        margin: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Text("if you have Account ",style: TextStyle(
                              color: lightColorScheme.primary,
                            )),
                            InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return Login();
                                }));
                              },
                              child: Text(
                                " Login",
                                style: TextStyle(color: Color(0xffe63946)),
                              ),
                            )
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: lightColorScheme.surfaceTint),
                            onPressed: () async {
                              UserCredential response = await signUp();
                              print("==================================");
                              if (response != null) {
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .add({"username": myusername, "email": myemail});
                                // جلب اليوزر نيم والاميل من الفير بيس
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return PaymentSelectionPage(total: widget.total1,con: false,);
                                }));
                              } else {
                                print("Sign Up Faild");
                              }

                              print("===================================");
                              widget.con == true
                                  ? Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return BasePage();
                              }))
                                  : Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return PaymentSelectionPage(con: false,);
                              }));
                            },
                            child: Text(
                              "Sign up",
                              style: TextStyle(fontSize: 20),
                            ))),
                  ],
                )),
          )
        ],
      ),
    );
    ;
  }
}

