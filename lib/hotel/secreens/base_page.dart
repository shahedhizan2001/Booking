import 'package:booking/hotel/secreens/search_destination1.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../account/myaccount.dart';
import '../../commen/theme/light_color_schema.dart';
import '../CurvedNavigationBar.dart';
import 'Booking.dart';
import 'go.dart';

final _firestore = FirebaseFirestore.instance;
late User signedInUser;

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);
  static final List<Widget> _widgetOptions = <Widget>[
    SectionHome(),
    SearchDestination1(),
    Booking(),
    const booking(),
  ];

  @override
  State<BasePage> createState() => _BasePageState();
}

var user;
String? getUser() {
  user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    print('email null=======================');
  } else {
    print("Email===============================");
    print(user?.uid);
  }
  return user?.uid.toString();
}

class _BasePageState extends State<BasePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: ClipRect(
        child: Scaffold(
          body: Center(
            child: BasePage._widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: CurvedNavigationBar(
            color: lightColorScheme.primary,
            buttonBackgroundColor: lightColorScheme.primary,
            backgroundColor: lightColorScheme.background,
            height: 50.h,
            animationDuration: const Duration(milliseconds: 500),
            items: [
              Icon(
                Icons.home,
                color: lightColorScheme.background,
                size: 25.sp,
              ),
              Icon(
                Icons.search,
                color: lightColorScheme.background,
                size: 25.sp,
              ),
              Icon(
                Icons.shopping_bag_outlined,
                color: lightColorScheme.background,
                size: 25.sp,
              ),
              Icon(
                Icons.person,
                color: lightColorScheme.background,
                size: 25.sp,
              ),
            ],
            index: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
