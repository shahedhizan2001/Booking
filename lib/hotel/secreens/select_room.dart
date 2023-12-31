import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../../../hotel/column_details.dart';
import '../../../../../hotel/stack_image.dart';
import '../../account/login.dart';
import '../../account/payment.dart';
import '../../commen/theme/global_functions.dart';
import '../../commen/theme/light_color_schema.dart';
import '../../screens/Finish_page.dart';
import '../elevated/hotel_secreen_cubit.dart';
import '../elevated/hotel_secreen_state.dart';
import 'base_page.dart';
import 'booking_hotel.dart';
import 'image_room.dart';
class RoomSection extends StatefulWidget {
  RoomSection(
      {Key? key,
        this.nameHotel,
        this.country,
        this.city,
        required this.image,
        this.star,
        this.checkIn,
        this.checkOut,
        this.numNight,
        this.edit,
        this.reservationId})
      : super(key: key);

  String? nameHotel;
  String? country;
  String? city;
  List image;
  int? star;
  String? checkIn;
  String? checkOut;
  int? numNight;
  bool? edit;
  String? reservationId;

  @override
  State<RoomSection> createState() => _RoomSectionState();
}
String? bed1;
String? bed2;
int? priceNight1;
int? priceNight2;
String? nameHotel;
String? country;
String? city;
List image = [];
int? Adults1;
int? Adults2;
int? children1;
int? children2;
String? checkIn;
String? checkOut;
int? star;
int? numNight;
int? totalPrice;
int? totalPrice1;
int? totalPrice2;
int? id1;
int? id2;
List images = [];
bool? edit;
String? reservationId;
int? numRoom = 0;

class _RoomSectionState extends State<RoomSection> {

  CollectionReference roomRef =
  FirebaseFirestore.instance.collection("room");
  List<Map<String, dynamic>> Room = [];
  CollectionReference reservationRef =
  FirebaseFirestore.instance.collection("reservationHotel");
  List<String> availableRooms = [];

  getRoom() async {
    Room = [];
    var roomQuerySnapshot = await roomRef
        .where("hotelname", isEqualTo: widget.nameHotel)
        .get();

    for (var roomDocument in roomQuerySnapshot.docs) {
      var roomData = roomDocument.data() as Map<String, dynamic>;
      var roomId = roomData['id'];
      var roomId1 = roomData['id1'];

      var isRoomAvailable = await checkRoomAvailability(roomId);
      if (isRoomAvailable) {
        setState(() {
          Room.add(roomData);
        });
      }
      if(roomId1 != null){
        var isRoomAvailable1 = await checkRoomAvailability1(roomId1);
        if (isRoomAvailable1) {
          setState(() {
            Room.add(roomData);
          });
        }
      }

    }
  }

  Future<bool> checkRoomAvailability(int roomId) async {
    var reservationQuerySnapshot = await reservationRef
        .where("id", isEqualTo: roomId)
        .get();

    var reservations = reservationQuerySnapshot.docs.map((doc) => doc.data())
        .toList();

    for (var reservation in reservations) {
      var reservationData = reservation as Map<String, dynamic>;
      var reservationCheckIn = DateFormat("d MMM, y").parse(reservationData['checkIn']);
      var reservationCheckOut = DateFormat("d MMM, y").parse(reservationData['checkOut']);

      if (reservationCheckIn != null && reservationCheckOut != null) {
        var isOverlapping = !(DateFormat("d MMM, y").parse(widget.checkOut!).isBefore(reservationCheckIn) ||
            DateFormat("d MMM, y").parse(widget.checkIn!).isAfter(reservationCheckOut));

        if (isOverlapping) {
          return false;
        }
      }
    }

    return true;
  }

  Future<bool> checkRoomAvailability1(int roomId1) async {
    var reservationQuerySnapshot = await reservationRef
        .where("id1", isEqualTo: roomId1)
        .get();

    var reservations = reservationQuerySnapshot.docs.map((doc) => doc.data())
        .toList();

    for (var reservation in reservations) {
      var reservationData = reservation as Map<String, dynamic>;
      var reservationCheckIn = DateFormat("d MMM, y").parse(reservationData['checkIn']);
      var reservationCheckOut = DateFormat("d MMM, y").parse(reservationData['checkOut']);

      if (reservationCheckIn != null && reservationCheckOut != null) {
        var isOverlapping = !(DateFormat("d MMM, y").parse(widget.checkOut!).isBefore(reservationCheckIn) ||
            DateFormat("d MMM, y").parse(widget.checkIn!).isAfter(reservationCheckOut));

        if (isOverlapping) {
          return false;
        }
      }
    }

    return true;
  }
  @override
  void initState() {
    getUser();
    getRoom();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelSecreenCubit, HotelSecreenStates>(
      builder: (context, state) {
        HotelSecreenCubit cubit = HotelSecreenCubit.get(context);
        return Scaffold(
          body: Room.isNotEmpty
              ? ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: Room.length,
            itemBuilder: (context, index) {
              return Column(children: [
                ExpandableNotifier(
                  child: RPadding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.black12),
                          borderRadius: BorderRadius.circular(15.r)),
                      child: Column(children: [
                        Row(
                          children: [
                            stackImage1(
                                funcyion: () {
                                  images = [
                                    "${Room[index]['image1']}",
                                    "${Room[index]['image2']}"
                                  ];
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) {
                                      return ImageSecreen(
                                        images: images,
                                      );
                                    },
                                  ));
                                },
                                image: "${Room[index]['image1']}",
                                h1: 180.h,
                                b: 2.h,
                                l: 12.w,
                                h2: 32.h,
                                w: 50.w,
                                title: "2"),
                            const RSizedBox(
                              width: 10,
                            ),
                            columnDetails(
                              title1: "Deluxe Room - ${Room[index]['numBed']} Bed",
                              title2: "${Room[index]['conditioning']}" ==
                                  "yes"
                                  ? "Conditioning"
                                  : "no",
                              title3: "${Room[index]['type']}" == "king"
                                  ? "King Bed"
                                  : "no",
                              title4: "${Room[index]['view']}" == "yes"
                                  ? "City View"
                                  : "no",
                              title5: "${Room[index]['space']} m2",
                              title6: "${Room[index]['tv']}" == "yes"
                                  ? "Tv"
                                  : "no",
                              icon1: Icons.bedroom_child_outlined,
                              icon2: Icons.location_city,
                              icon3: Icons.area_chart_outlined,
                              icon4: Icons.tv,
                              icon5: Icons.severe_cold,
                            )
                          ],
                        ),
                        ScrollOnExpand(
                          scrollOnExpand: true,
                          scrollOnCollapse: false,
                          child: Column(
                            children: [
                              ExpandablePanel(
                                theme: const ExpandableThemeData(
                                    hasIcon: false,
                                    headerAlignment:
                                    ExpandablePanelHeaderAlignment
                                        .center),
                                header: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "The price for 1 room * 1 person",
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            color: Colors.black45,
                                            fontWeight:
                                            FontWeight.normal),
                                      ),
                                      Text(
                                        cubit.selectedCurrency == 'USD'
                                            ? "\$ ${Room[index]['price']}"
                                            : "SYP  ${Room[index]['price'] * 14500}",
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                collapsed: const SizedBox.shrink(),
                                expanded: Column(children: [
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      RPadding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Room Only",
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                            RSizedBox(
                                              width: 170,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                RPadding(
                                                  padding:
                                                  const EdgeInsets
                                                      .all(5.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text(
                                                        "Total for ${widget.numNight} night * ${cubit.roomSelectionCount == 0 ? cubit.countA1 : cubit.countA2} person",
                                                        style: TextStyle(
                                                            fontSize:
                                                            15.sp,
                                                            color: Colors
                                                                .black45,
                                                            fontWeight:
                                                            FontWeight
                                                                .normal),
                                                      ),
                                                      const RSizedBox(
                                                        width: 16,
                                                      ),
                                                      widget.numNight != 1
                                                          ? Text(
                                                        cubit.selectedCurrency ==
                                                            "USD"
                                                            ? "\$ ${((Room[index]['price'] * (widget.numNight) / 1.2) * ((cubit.countA1 == 1) ? cubit.countA1 : cubit.countA1 / 1.5)).toInt()}"
                                                            : "SYP ${((Room[index]['price'] * 14500 * (widget.numNight) / 1.2) * ((cubit.countA1 == 1) ? cubit.countA1 : cubit.countA1 / 1.5)).toInt()}",
                                                        style: TextStyle(
                                                            fontSize: 16
                                                                .sp,
                                                            color: Colors
                                                                .black,
                                                            fontWeight:
                                                            FontWeight.bold),
                                                      )

                                                          : Text(
                                                        cubit.selectedCurrency.last==
                                                            'USD'
                                                            ? "\$  ${( Room[index]['price']! * ((cubit.countA1 == 1) ? cubit.countA1 : cubit.countA1 / 1.5)).toInt()}"
                                                            : "SYP  ${((Room[index]['price']! * 14500) * ((cubit.countA1 == 1) ? cubit.countA1 : cubit.countA1 / 1.5)).toInt()}",
                                                        style: TextStyle(
                                                            fontSize: 16
                                                                .sp,
                                                            color: Colors
                                                                .black,
                                                            fontWeight:
                                                            FontWeight.bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const RSizedBox(
                                              width: 60,
                                            ),
                                            ElevatedButton(
                                                onPressed: () async {
                                                  //  print(" rooms $Room1");
                                                  final isAuth = await GlobalFunctions().isAuth();
                                                  cubit.countRoom();
                                                  if (cubit.roomSelectionCount == 2 && cubit.num_room == 2) {

                                                    numNight = widget.numNight;
                                                    priceNight2 =await Room[index]['price'];
                                                    numRoom = cubit.num_room;
                                                    Adults2 = cubit.countA2;
                                                    children2 = cubit.selectedAge2.length;
                                                    totalPrice2 =await numNight != 1 ? (priceNight2! * numNight!) ~/ 1.1 : priceNight2! * numNight!;
                                                    id2 =await Room[index]['id'];
                                                    bed2 = await Room[index]['type'];
                                                    if (isAuth == false) {
                                                      Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                          builder: (context) {
                                                            return Login(total: Room[index]['price'], con: false);
                                                          },
                                                        ),
                                                      );
                                                    } else if (cubit.selectedPayment == []) {
                                                      print(cubit.selectedPayment);
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) {
                                                                return PaymentSelectionPage(total: totalPrice,con: false,);
                                                              }));
                                                    } else {
                                                      print(cubit.selectedPayment);

                                                      Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                          builder: (context) {
                                                            return FinishPage();
                                                          },
                                                        ),
                                                      );
                                                    }
                                                    cubit.roomSelectionCount =
                                                    0;
                                                  }
                                                  if (cubit.roomSelectionCount == 1 && cubit.num_room == 1) {
                                                    numNight = widget.numNight;
                                                    priceNight1 =
                                                    await Room[index]['price'];
                                                    numRoom = cubit.num_room;
                                                    Adults1 = cubit.countA1;
                                                    children1 =
                                                        cubit.selectedAge1
                                                            .length;
                                                    totalPrice1 =
                                                    await numNight != 1
                                                        ? (priceNight1! *
                                                        numNight!) ~/ 1.1
                                                        : priceNight1! *
                                                        numNight!;
                                                    id1 =
                                                    await Room[index]['id'];
                                                    bed1 =
                                                    await Room[index]['type'];
                                                    if (cubit.countA1 != 0) {
                                                      if (isAuth == false) {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) {
                                                              return Login(
                                                                  total: Room[index]['price'],
                                                                  con: false);
                                                            },
                                                          ),
                                                        );
                                                      } else if (cubit
                                                          .selectedPayment ==
                                                          []) {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) {
                                                              return PaymentSelectionPage(
                                                                total: totalPrice,
                                                                con: false,);
                                                            },
                                                          ),
                                                        );
                                                      } else {
                                                        Navigator.of(context)
                                                            .push(
                                                          MaterialPageRoute(
                                                            builder: (context) {
                                                              return FinishPage();
                                                            },
                                                          ),
                                                        );
                                                      }
                                                    }
                                                    else
                                                    if (cubit.countA1 == 0) {
                                                      showDialog(
                                                        context: context,
                                                        builder: (
                                                            BuildContext context) {
                                                          return AlertDialog(
                                                            content: Text(
                                                                "you must be select number of guest"),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator
                                                                        .pop(
                                                                        context),
                                                                child: Text(
                                                                    "Ok"),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    }
                                                    cubit.roomSelectionCount = 0;
                                                  }


                                                  if (cubit.roomSelectionCount == 1 && cubit.num_room == 2) {

                                                    numNight = widget.numNight;
                                                    priceNight1 =await Room[index]['price'];
                                                    numRoom = cubit.num_room;
                                                    Adults1 = cubit.countA1;
                                                    children1 = cubit.selectedAge1.length;
                                                    totalPrice1 =await numNight != 1 ? (priceNight1! * numNight!) ~/ 1.1 : priceNight1! * numNight!;
                                                    id1 =await Room[index]['id'];
                                                    bed1 =await Room[index]['type'];

                                                    showDialog(
                                                      context: context,
                                                      builder:
                                                          (BuildContext
                                                      context) {
                                                        return AlertDialog(
                                                          // title: Text("warning"),
                                                          content: Text(
                                                              "Please select another room"),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      context),
                                                              child: Text(
                                                                  "Ok"),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  }
                                                  nameHotel = widget.nameHotel;
                                                  image = widget.image;
                                                  country = widget.country;
                                                  city = widget.city;
                                                  checkIn = widget.checkIn;
                                                  checkOut = widget.checkOut;
                                                  star = widget.star;
                                                  edit = widget.edit;
                                                  reservationId = widget.reservationId;
                                                  await addReservationHotel();
                                                  print("done");
                                                },
                                                style: ElevatedButton
                                                    .styleFrom(
                                                  elevation: 0,
                                                  fixedSize:
                                                  Size(100.w, 35.h),
                                                  backgroundColor:
                                                  lightColorScheme
                                                      .primary,
                                                  shape:
                                                  const RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius.all(
                                                        Radius
                                                            .circular(
                                                            30)),
                                                  ),
                                                ),
                                                child: Text("Select",
                                                    style: TextStyle(
                                                        fontSize: 15)))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const RSizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 1,
                                    color: Colors.black12,
                                  ),
                                ]),
                              ),
                              const Divider(
                                height: 1,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                children: <Widget>[
                                  Builder(
                                    builder: (context) {
                                      var controller =
                                      ExpandableController.of(context,
                                          required: true)!;

                                      return controller.expanded
                                          ? RPadding(
                                        padding:
                                        const EdgeInsets.all(
                                            8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.toggle();
                                          },
                                          child: Row(children: [
                                            const RSizedBox(
                                                width: 200),
                                            Text(
                                              "Hide Options",
                                              style: TextStyle(
                                                  color:
                                                  lightColorScheme
                                                      .primary,
                                                  fontSize: 16.sp),
                                            ),
                                            const RSizedBox(
                                              width: 8,
                                            ),
                                            SvgPicture.asset(
                                              "assets/icons/2203524_arrow_botton_down_menu_icon.svg",
                                              height: 16.h,
                                              color:
                                              lightColorScheme
                                                  .primary,
                                            )
                                          ]),
                                        ),
                                      )
                                          : RPadding(
                                        padding:
                                        const EdgeInsets.all(
                                            8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            controller.toggle();
                                          },
                                          child: Row(children: [
                                            const RSizedBox(
                                                width: 200),
                                            Text(
                                              "View Options",
                                              style: TextStyle(
                                                  color:
                                                  lightColorScheme
                                                      .primary,
                                                  fontSize: 16.sp),
                                            ),
                                            const RSizedBox(
                                              width: 8,
                                            ),
                                            SvgPicture.asset(
                                              "assets/icons/2203524_arrow_botton_down_menu_icon.svg",
                                              height: 16.h,
                                              color:
                                              lightColorScheme
                                                  .primary,
                                            )
                                          ]),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]
                        //child: ,
                      ),
                    ),
                  ),
                ),
              ]);
            },
          )
              : Container(
              child: const Center(
                child: CircularProgressIndicator(),
              )),
        );
      },
    );
  }
}

addReservationHotel() {
  CollectionReference reservationRef = FirebaseFirestore.instance.collection("reservationHotel");
  if(numRoom == 1){
    if (edit == false) {
      reservationRef.add({
        'city': city,
        'nameHotel': nameHotel,
        'priceNight': priceNight1,
        'bed': bed1,
        'image': image[0],
        'image1':image[1],
        'image2':image[2],
        'image3':image[3],
        'image4':image[4],
        'image5':image[5],
        'numRoom': numRoom,
        'userId': getUser(),
        'star': star,
        'numAdults': Adults1,
        'checkIn': checkIn,
        'checkOut': checkOut,
        'numNight': numNight,
        'totalPrice': totalPrice1,
        'id': id1,
        'avaliable': false

      }).then((value) {
        reservationRef.doc(value.id).update({
          'reservationId': value.id,
        });
      });
      print("final");
    } else if (edit == true) {
      print("update");
      reservationRef.doc(reservationId).update({
        'city': city,
        'nameHotel': nameHotel,
        'priceNight': priceNight1,
        'bed': bed1,
        'image': image[0],
        'numRoom': numRoom,
        'userId': getUser(),
        'star': star,
        'numAdults': Adults1,
        'checkIn': checkIn,
        'checkOut': checkOut,
        'numNight': numNight,
        'totalPrice': totalPrice1,
        'id': id1,
        'reservationId': reservationId,
        'avaliable': false
      });
      print("update");
    }
  } else{
    if (edit == false) {
      reservationRef.add({
        'city': city,
        'nameHotel': nameHotel,
        'priceNight': priceNight1,
        'priceNight1': priceNight2,
        'bed': bed1,
        'bed1': bed2,
        'image': image[0],
        'image1':image[1],
        'image2':image[2],
        'image3':image[3],
        'image4':image[4],
        'image5':image[5],
        'numRoom': numRoom,
        'userId': getUser(),
        'star': star,
        'numAdults': Adults1,
        'numAdults1': Adults2,
        'checkIn': checkIn,
        'checkOut': checkOut,
        'numNight': numNight,
        'totalPrice': totalPrice1! + totalPrice2! ,
        'id': id1,
        'id1': id2,
        'avaliable': false

      }).then((value) {
        reservationRef.doc(value.id).update({
          'reservationId': value.id,
        });
      });
      print("final");
    } else if (edit == true) {
      print("update");
      reservationRef.doc(reservationId).update({
        'city': city,
        'nameHotel': nameHotel,
        'priceNight': priceNight1,
        'priceNight1': priceNight2,
        'bed': bed1,
        'bed1': bed2,
        'image': image[0],
        'numRoom': numRoom,
        'userId': getUser(),
        'star': star,
        'numAdults': Adults1,
        'numAdults1': Adults2,
        'checkIn': checkIn,
        'checkOut': checkOut,
        'numNight': numNight,
        'totalPrice': totalPrice2! + totalPrice1! ,
        'id': id1,
        'id1': id2,
        'reservationId': reservationId,
        'avaliable': false
      });
      print("update");
    }
  }

}


