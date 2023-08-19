import 'package:booking/hotel/secreens/room_in_hotel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../elevated/hotel_secreen_cubit.dart';
import '../elevated/hotel_secreen_state.dart';
import 'base_page.dart';

class BookingHotel extends StatefulWidget {
  BookingHotel({super.key, this.numroom});
   int ? numroom;
  @override
  State<BookingHotel> createState() => _BookingHotelState();
}

class _BookingHotelState extends State<BookingHotel> {
  CollectionReference reservationRef =
      FirebaseFirestore.instance.collection("reservationHotel");

  List reservation = [];
  List images = [];

  bool isLoading = true;

  getReservationHotel() async {
    if (getUser() == null) {
      setState(() {
        reservation = [];
        isLoading = false;
      });
    } else {
      await reservationRef
          .where("userId", isEqualTo: getUser())
          .get()
          .then((value) {
        if (value.size > 0) {
          value.docs.forEach((element) {
            setState(() {
              reservation.add(element.data());
            });
          });
        }
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  void initState() {
    getReservationHotel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelSecreenCubit, HotelSecreenStates>(
        builder: (context, state) {
          HotelSecreenCubit cubit =HotelSecreenCubit();
      return Scaffold(
          body: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : reservation.isEmpty
                  ? Center(
                      child: Text(
                        'No reservation yet',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: reservation.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: RPadding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              children: [
                                RPadding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(children: [
                                    Container(
                                      child: Image(
                                        image: NetworkImage(
                                            "${reservation[index]['image']}"),
                                        fit: BoxFit.cover,
                                        height: 80.h,
                                        width: 100.w,
                                      ),
                                    ),
                                    RSizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              "${reservation[index]['nameHotel']}, ${reservation[index]['city']}"),
                                          RSizedBox(
                                            height: 20,
                                            width: 100,
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount:
                                                          reservation[index]
                                                              ['star'],
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Icon(Icons.star,
                                                            size: 14,
                                                            color:
                                                                Colors.yellow);
                                                      }),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    RSizedBox(
                                      width: 40,
                                    ),
                                    Column(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              if (DateFormat('d MMM, y')
                                                  .parse(reservation[index]
                                                      ['checkIn'])
                                                  .isBefore(DateTime.now())) {
                                                print("No");
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    title: Text("Warning"),
                                                    content: Text(
                                                        "The reservation cannot be modified because the reservation has expired."),
                                                    actions: [
                                                      TextButton(
                                                        child: Text("OK"),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              } else {
                                                images = [
                                                  reservation[index]['image'],
                                                  reservation[index]['image1'],
                                                  reservation[index]['image2'],
                                                  reservation[index]['image3'],
                                                  reservation[index]['image4'],
                                                  reservation[index]['image5']
                                                ];

                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => Hotel(
                                                            cityHotel:
                                                                "${reservation[index]['city']}",
                                                            nameHotel:
                                                                "${reservation[index]['nameHotel']}",
                                                            image: images,
                                                            star: reservation[
                                                                index]['star'],
                                                            reservationId:
                                                                "${reservation[index]['reservationId']}",
                                                            userId:
                                                                "${reservation[index]['userId']}",
                                                            edit: true)));
                                              }
                                            },
                                            icon: Icon(Icons.edit)),
                                        Container(
                                          child: Text(
                                              "${reservation[index]['id']}"),
                                        ),
                                      ],
                                    ),
                                  ]),
                                ),
                                Container(
                                  height: 1.h,
                                  color: Colors.black12,
                                ),
                                RPadding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Room - 1",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${reservation[index]['bed']}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      RSizedBox(width: 210),
                                      Text(
                                          "${reservation[index]['numAdults']} Adults")
                                    ],
                                  ),
                                ),
                                widget.numroom==2? RPadding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Room - 2",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "${reservation[index]['bed']}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      RSizedBox(width: 210),
                                      Text(
                                          "${reservation[index]['numAdults']} Adults")
                                    ],
                                  ),
                                ):RSizedBox(),
                                RPadding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Number of nights",
                                      ),
                                      RSizedBox(width: 160),
                                      Text(
                                          "${reservation[index]['numNight']} night")
                                    ],
                                  ),
                                ),
                                RPadding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Check in",
                                      ),
                                      RSizedBox(width: 200),
                                      Text("${reservation[index]['checkIn']}")
                                    ],
                                  ),
                                ),
                                RPadding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Check Out",
                                      ),
                                      RSizedBox(width: 190),
                                      Text("${reservation[index]['checkOut']}")
                                    ],
                                  ),
                                ),
                                RPadding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "1 Room * 1 night",
                                      ),
                                      RSizedBox(width: 170),
                                      Text(
                                          "\$ ${reservation[index]['priceNight'].toString()}")
                                    ],
                                  ),
                                ),
                               widget.numroom==2? RPadding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "2 Room * 1 night",
                                      ),
                                      RSizedBox(width: 170),
                                      Text(
                                          "\$ ${reservation[index]['priceNight'].toString()}")
                                    ],
                                  ),
                                ):RSizedBox(),
                                RPadding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text("Total Price",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      RSizedBox(width: 210),
                                      Text(
                                          "\$ ${reservation[index]['totalPrice'].toString()}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ));
    });
  }
}
