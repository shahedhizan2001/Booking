import 'package:booking/hotel/secreens/search_destination2.dart';
import 'package:booking/hotel/secreens/search_hotel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../commen/theme/light_color_schema.dart';
import '../app_bar.dart';
import '../elevated/hotel_secreen_cubit.dart';
import '../elevated/hotel_secreen_state.dart';
import '../elevatedbottom.dart';

class HotelSection extends StatefulWidget {
  HotelSection({Key? key, this.country, this.city}) : super(key: key);
  final country;
  final city;

  @override
  State<HotelSection> createState() => _HotelSectionState();
}

class _HotelSectionState extends State<HotelSection> {
  List country = [];
  List finalCountry = [];
  List city = [];
  var myinformation, x;
  String? inCity;
  String? inCountry;
  DateTime dIn = DateTime.now(), dOut = DateTime.now();

  CollectionReference ref = FirebaseFirestore.instance.collection("nation");

  getCountry() async {
    var responsebody = await ref.get();
    responsebody.docs.forEach((element) {
      x = element.data();
      setState(() {
        country.add(x['country']);
      });
    });
    finalCountry = country.toSet().toList();
  }

  getCity() async {
    city = [];
    await ref.where("country", isEqualTo: "${inCountry}").get().then((value) {
      value.docs.forEach((element) {
        x = element.data();
        setState(() {
          city.add(x['city']);
        });
      });
    });
  }

  @override
  void initState() {
    getCountry();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelSecreenCubit, HotelSecreenStates>(
      builder: (context, state) {
        HotelSecreenCubit cubit = HotelSecreenCubit.get(context);
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: appBar(title: "Search",centre: true,
             leading: IconButton(onPressed: () {
               Navigator.pushNamed(context, 'BasePage');
             }, icon:Icon( Icons.arrow_back_outlined))
            ),
            body: Container(
              child: Column(children: [
                RSizedBox(
                  height: 15,
                ),
                RPadding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SearchDestination2()));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Colors.black45,
                        ),
                        RSizedBox(
                          width: 10,
                        ),
                        Text(
                          '${widget.country}, ${widget.city}' == "null, null"
                              ? "Where are you going?"
                              : '${widget.country}, ${widget.city}',
                          style: TextStyle(color: Colors.black45),
                        )
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      elevation: 0,
                      fixedSize: Size.fromHeight(60),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black45),
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            dIn = cubit.chooseDateRangePicker(context: context);
                            print(" in ${dIn}");
                            print("rrrrrrrrrrrrrrrrrrrrrrrrrr");
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.black45,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Check in",
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                  Text(
                                    DateFormat("dd-MM-yyyy")
                                        .format(cubit.dateRange.start)
                                        .toString(),
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            elevation: 0,
                            minimumSize: Size(160, 60),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black45),
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            dOut =
                                cubit.chooseDateRangePicker(context: context);
                            print(dOut);
                            print("wwwwwwwwwwwwwwwwwwwwwwwwww");
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.arrow_back_rounded,
                                color: Colors.black45,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Text(
                                    "Check out",
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                  Text(
                                    DateFormat("dd-MM-yyyy")
                                        .format(cubit.dateRange.end)
                                        .toString(),
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                ],
                              )
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            elevation: 0,
                            minimumSize: Size(160, 60),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.black45),
                                borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) => BlocBuilder<HotelSecreenCubit,HotelSecreenStates>(
                            builder: (context, state) {
                              return  SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          cubit.countA1=2;
                                          cubit.countA2=0;
                                          cubit.num_room=1;
                                          cubit.selectedAge1.length=0;
                                          cubit.selectedAge2.length=0;
                                          Navigator.pop(context);
                                          cubit.selectFilter();
                                        },
                                        child: Text(
                                          "1 Room, 2 Adults ,0 children",
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontWeight: FontWeight.normal),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          cubit.countA1=1;
                                          cubit.countA2=0;
                                          cubit.num_room=1;
                                          cubit.selectedAge1.length=0;
                                          cubit.selectedAge2.length=0;
                                          Navigator.pop(context);
                                          cubit.selectFilter();
                                        },
                                        child: Text(
                                          "1 Room, 1 Adults ,0 children",
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontWeight: FontWeight.normal),
                                        )),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, 'OptionSecreen');
                                        },
                                        child: Text(
                                          "More options",
                                          style: TextStyle(
                                              color: Colors.black45,
                                              fontWeight: FontWeight.normal),
                                        ))
                                  ],
                                ),
                              );
                            },
                          ));
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.group,
                          color: Colors.black45,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Guests",
                              style: TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              cubit.countA1==0
                                  ?"you must be choose number of guest"
                                  : '${cubit.num_room}Room,'
                                      ' ${cubit.countA1 + cubit.countA2} Adults ,'
                                      '${cubit.selectedAge1.length + cubit.selectedAge2.length} children',
                              style: TextStyle(color: Colors.black45),
                            ),
                          ],
                        )
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      elevation: 0,
                      fixedSize: Size.fromHeight(60),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black45),
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                defaultElevatedBottom(
                  icons: Icons.search,
                  title: "Search hotels",
                  onPressed: () {
                    if ('${widget.country}, ${widget.city}' != "null, null"&&cubit.countA1!=0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchHotel(
                                  city: widget.city,
                                  country: widget.country,
                                )),
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("warning"),
                            content:Text("Please select destination and guests"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Ok"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  padding: EdgeInsets.all(12.0),
                  colors: Colors.white,
                  backgroundColor: lightColorScheme.primary,
                  size: Size.fromHeight(50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                ),
              ]),
            ));
      },
    );
  }
}
