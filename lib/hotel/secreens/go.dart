import 'package:booking/hotel/secreens/room_in_hotel.dart';
import 'package:booking/l10n/app_localizations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../elevated/hotel_secreen_cubit.dart';
import '../elevated/hotel_secreen_state.dart';
import '../rowSection.dart';

class SectionHome extends StatefulWidget {
  SectionHome({Key? key}) : super(key: key);

  @override
  State<SectionHome> createState() => _SectionHomeState();
}

class _SectionHomeState extends State<SectionHome> {
  CollectionReference ref = FirebaseFirestore.instance.collection("hotel");

  CollectionReference refSy = FirebaseFirestore.instance.collection("hotel");

  getHotel() async {
    await ref.orderBy("evaluation", descending: true).get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          allHotel.add(element.data());
        });
      });
    });
  }

  getHotelSy() async {
    await refSy
        .where("country", isEqualTo: "Syria")
       // .orderBy("evaluation", descending: true)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          syHotel.add(element.data());
        });
      });
    });
  }

  List imagesHotel = [];

  @override
  void initState() {
    getHotel();
    getHotelSy();

  }

  // bool _isLoading = false;
  List allHotel = [];
  List syHotel = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelSecreenCubit, HotelSecreenStates>(
        builder: (context, state) {
      return Scaffold(
          body: ListView(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 225.h,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 0.w,
                    right: 0.w,
                    child: ClipPath(
                      clipper: CustomClipPath(),
                      child: Container(
                        child: Image(
                          image: AssetImage("assets/image/6May-Feat.jpg"),
                          fit: BoxFit.cover,
                          height: 200.h,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      right: 3.w,
                      top: 8.h,
                      child: ClipPath(
                        clipper: CustomClipPath(),
                      )),
                  Positioned(
                    top: 60.h,
                    left: 30.w,
                    height: 220.h,
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'FlightPage');
                          },
                          child: Container(
                            width: 130.w,
                            height: 70.h,
                            child: Column(
                              children: [
                                RSizedBox(
                                  height: 10,
                                ),
                                SvgPicture.asset(
                                  "assets/icons/airplane-svgrepo-com (2).svg",
                                  height: 40,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.flight,
                                  style: TextStyle(color: Colors.black),
                                )
                              ],
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              padding: EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.r))),
                        ),
                        RSizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'HotelSection');
                          },
                          child: Container(
                            width: 130.w,
                            height: 70.h,
                            child: Column(
                              children: [
                                RSizedBox(
                                  height: 10,
                                ),
                                SvgPicture.asset(
                                  "assets/icons/hotel-svgrepo-com (4).svg",
                                  height: 30,
                                ),
                                RSizedBox(
                                  height: 10,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.hotel,
                                  style: TextStyle(color: Colors.black),
                                )
                              ],
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              padding: REdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.r))),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            RPadding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Top international hotels!",
                style: TextStyle(fontSize: 20),
              ),
            ),
            RSizedBox(
              height: 4,
            ),
            SizedBox(
              height: 200,
              width: 2000,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, i) {
                          return rowSection(
                              country: allHotel.isEmpty
                                  ? "Loading "
                                  : "${allHotel[i]['country']}",
                              city: allHotel.isEmpty
                                  ? "Loading "
                                  : "${allHotel[i]['city']}",
                              name: allHotel.isEmpty
                                  ? "Loading "
                                  : "${allHotel[i]['name']}",
                              image: allHotel.isEmpty
                                  ? "Loading "
                                  : "${allHotel[i]['image']}",
                              h: () {
                                imagesHotel = [
                                  "${allHotel[i]['image']}",
                                  "${allHotel[i]['image1']}",
                                  "${allHotel[i]['image2']}",
                                  "${allHotel[i]['image3']}",
                                  "${allHotel[i]['image4']}",
                                  "${allHotel[i]['image5']}",
                                ];
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Hotel(
                                              nameHotel:
                                                  "${allHotel[i]['name']}",
                                              cityHotel:
                                                  "${allHotel[i]['city']}",
                                              countryHotel:
                                                  "${allHotel[i]['country']}",
                                              image: imagesHotel,
                                              star: allHotel[i]['star'],
                                              edit: false,
                                            )));
                                print("${allHotel[i]['name']}");
                              });
                        }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Syria's most popular hotels",
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 200,
              width: 2000,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, i) {
                          return rowSection(
                              country: syHotel.isEmpty
                                  ? "Loading "
                                  : "${syHotel[i]['country']}",
                              city: syHotel.isEmpty
                                  ? "Loading "
                                  : "${syHotel[i]['city']}",
                              name: syHotel.isEmpty
                                  ? "Loading "
                                  : "${syHotel[i]['name']}",
                              image: syHotel.isEmpty
                                  ? "Loading "
                                  : "${syHotel[i]['image']}",
                              h: () {
                                imagesHotel = [
                                  "${syHotel[i]['image']}",
                                  "${syHotel[i]['image1']}",
                                  "${syHotel[i]['image2']}",
                                  "${syHotel[i]['image3']}",
                                  "${syHotel[i]['image4']}",
                                  "${syHotel[i]['image5']}",
                                ];
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Hotel(
                                              nameHotel:
                                                  "${syHotel[i]['name']}",
                                              countryHotel:
                                                  "${syHotel[i]['country']}",
                                              cityHotel:
                                                  "${syHotel[i]['city']}",
                                              image: imagesHotel,
                                              star: syHotel[i]['star'],
                                              edit: false,
                                            )));
                              });
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]));
    });
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    final path = Path();
    path.lineTo(0, h / 1.5);
    path.quadraticBezierTo(w / 2, h, w, h / 1.55);

    path.lineTo(w, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
