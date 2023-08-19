
import 'dart:async';

import 'package:booking/hotel/secreens/room_in_hotel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:connectivity/connectivity.dart';

import '../../commen/theme/light_color_schema.dart';
import '../elevated/hotel_secreen_cubit.dart';
import '../elevated/hotel_secreen_state.dart';
import '../textfield.dart';
import 'filter_secreen.dart';
import 'map_secreen.dart';
import 'no_internet_Secreen.dart';

var x;
var z = 0;
double y = 0;
bool hasHotelsWithSelectedStars = false;
bool showLoadingIndicator = true;
int selectedNumStar = 0;
int? maxPrice;
int? minPrice;
List avg2 = [];

class SearchHotel extends StatefulWidget {
  SearchHotel({Key? key, this.city, this.country, this.star}) : super(key: key);
  String? city;
  String? country;
  int? star;

  @override
  State<SearchHotel> createState() => _SearchHotelState();
}

class _SearchHotelState extends State<SearchHotel> {
  bool isInternetConnected = true;

  List hotel = [];
  int? counter;

  CollectionReference ref = FirebaseFirestore.instance.collection("hotel");

  CollectionReference refR = FirebaseFirestore.instance.collection("room");

  List<double> avg = [];


  getHotel() async {
    avg = [];
    hotel = [];

    await ref.where("city", isEqualTo: "${widget.city}").get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          hotel.add(element.data());
        });
      });
    });

    avg = List<double>.filled(hotel.length, 0);

    for (int i = 0; i < hotel.length; i++) {
      List avgPrice = [];
      await refR
          .where("hotelname", isEqualTo: hotel[i]['name'])
          .get()
          .then((value) {
        value.docs.forEach((element) {
          x = element.data();
          avgPrice.add(x['price']);
        });
      });

      double sum = 0;
      for (int j = 0; j < avgPrice.length; j++) {
        sum += avgPrice[j];
      }

      setState(() {
        avg[i] = sum / avgPrice.length;
      });
    }
    avg2 = avg;
  }


  Future<void> getSort(String x, int star, double priceFilter) async {
    if (x == 'Lowest price') {
      await getHotel();

      for (int i = 0; i < hotel.length - 1; i++) {
        for (int j = 0; j < hotel.length - i - 1; j++) {
          if (avg[j] > avg[j + 1]) {
            var tempHotel = hotel[j];
            hotel[j] = hotel[j + 1];
            hotel[j + 1] = tempHotel;

            var tempAvg = avg[j];
            avg[j] = avg[j + 1];
            avg[j + 1] = tempAvg;
          }
        }
      }
    } else if (x == 'Highest guest rating') {
      await ref
          .where("city", isEqualTo: "${widget.city}")
          .orderBy("Rate", descending: true)
          .get()
          .then((value) async {
        setState(() {
          hotel = value.docs.map((doc) => doc.data()).toList();
        });

        // Update avg list based on the new order
        avg = List<double>.filled(hotel.length, 0);
        for (int i = 0; i < hotel.length; i++) {
          List avgPrice = [];
          await refR
              .where("hotelname", isEqualTo: hotel[i]['name'])
              .get()
              .then((value) {
            value.docs.forEach((element) {
              var y;
              y = element.data();
              avgPrice.add(y['price']);
            });
          });

          double sum = 0;
          for (int j = 0; j < avgPrice.length; j++) {
            sum += avgPrice[j];
          }

          setState(() {
            avg[i] = sum / avgPrice.length;
          });
        }
      });
    } else if (x == 'Distance from center') {
      await ref
          .where("city", isEqualTo: "${widget.city}")
          .orderBy("distance", descending: false)
          .get()
          .then((value) async {
        setState(() {
          hotel = value.docs.map((doc) => doc.data()).toList();
        });

        // Update avg list based on the new order
        avg = List<double>.filled(hotel.length, 0);
        for (int i = 0; i < hotel.length; i++) {
          List avgPrice = [];
          await refR
              .where("hotelname", isEqualTo: hotel[i]['name'])
              .get()
              .then((value) {
            value.docs.forEach((element) {
              var y;
              y = element.data();
              avgPrice.add(y['price']);
            });
          });

          double sum = 0;
          for (int j = 0; j < avgPrice.length; j++) {
            sum += avgPrice[j];
          }

          setState(() {
            avg[i] = sum / avgPrice.length;
          });
        }
      });
    } else
      if (x == "Filter") {
      List<Map<String, dynamic>> filteredHotels = [];


      if (star == 0) {
        getHotel().then((_) {
          for (int i = 0; i < hotel.length; i++) {
            if (avg[i] <= priceFilter) {
              filteredHotels.add(hotel[i]);
            }
          }

          setState(() {
            hotel = filteredHotels;
          });
          if (hotel.isEmpty) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("No Hotels Found"),
                content: Text("There are no hotels with the selected criteria."),
                actions: [
                  TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          }
        });
      } else {
        ref
            .where("city", isEqualTo: "${widget.city}")
            .where("star", isEqualTo: star)
            .get()
            .then((value) {
          setState(() {
            hotel = value.docs.map((doc) => doc.data()).toList();

            hasHotelsWithSelectedStars = hotel.isNotEmpty;
            if (hasHotelsWithSelectedStars)
              showLoadingIndicator = false;
            else
              showLoadingIndicator = true;
            if (hotel.isEmpty) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("No Hotels Found"),
                  content: Text("There are no Hotels with $star stars."),
                  actions: [
                    TextButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            }
          });
        }).then((_) {
          // Update avg list based on the new order
          avg = List<double>.filled(hotel.length, 0);
          List<Future> futures = [];
          for (int i = 0; i < hotel.length; i++) {
            List avgPrice = [];
            futures.add(refR
                .where("hotelname", isEqualTo: hotel[i]['name'])
                .get()
                .then((value) {
              value.docs.forEach((element) {
                var y;
                y = element.data();
                avgPrice.add(y['price']);
              });

              double sum = 0;
              for (int j = 0; j < avgPrice.length; j++) {
                sum += avgPrice[j];
              }

              setState(() {
                avg[i] = sum / avgPrice.length;
              });
            }));
          }

          Future.wait(futures).then((_) {
            for (int i = 0; i < hotel.length; i++) {
              if (avg[i] <= priceFilter) {
                filteredHotels.add(hotel[i]);
              }
            }

            setState(() {
              hotel = filteredHotels;
            });
          });
        });
      }
    }

  }

  @override
  void initState() {
    getHotel();
    checkInternetAvailability();

    super.initState();
  }

  Future<void> checkInternetAvailability() async {
    bool isConnected = await checkInternetConnectivity();
    setState(() {
      isInternetConnected = isConnected;
    });
  }

  // تستخدم هذه الوظيفة للتحقق من توافر الاتصال بالإنترنت
  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelSecreenCubit, HotelSecreenStates>(
      builder: (context, state) {
        HotelSecreenCubit cubit = HotelSecreenCubit.get(context);

        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              iconTheme: IconThemeData(
                color: lightColorScheme.primary,
              ),
              title: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${widget.country}, ${widget.city}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.black12,
                        ),
                        RSizedBox(
                          width: 3,
                        ),
                        Text(
                          "${cubit.countA1 + cubit.countA2 + cubit.selectedAge1.length + cubit.selectedAge2.length}",
                          style: TextStyle(
                              color: Colors.black45,
                              fontWeight: FontWeight.normal,
                              fontSize: 16),
                        ),
                        RSizedBox(
                          width: 7,
                        ),
                        Row(
                          children: [
                            Text(
                              DateFormat("dd/MM")
                                  .format(cubit.dateRange.start)
                                  .toString(),
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16),
                            ),
                            Text(
                              "-",
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16),
                            ),
                            Text(
                              DateFormat("dd/MM")
                                  .format(cubit.dateRange.end)
                                  .toString(),
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ]),
              actions: [
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.attach_money_rounded))
              ],
            ),
            body: ListView(children: [
              Column(children: [
                RSizedBox(
                  height: 7,
                ),
                defaultTextFieldSection(
                    prefixIcon: Icons.search,
                    labelText: "Search Hotel",
                    fillColor: Colors.black12),
                RPadding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                        "${hotel.length} properties found in ${widget.city}",
                        style: TextStyle(color: Colors.grey)),
                  ),
                ),
                Row(
                  children: [
                    RPadding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => BlocBuilder<HotelSecreenCubit,
                                HotelSecreenStates>(
                              builder: (context, state) {
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      RPadding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(children: [
                                          Text(
                                            "Sort by",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          RSizedBox(
                                            width: 240,
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                "CANCEL",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: lightColorScheme
                                                        .primary),
                                              ))
                                        ]),
                                      ),
                                      CheckboxListTile(
                                        title: Text('Lowest price'),
                                        value: cubit.selectedSort
                                            .contains('Lowest price'),
                                        onChanged: (value) {
                                          cubit.toggleSort('Lowest price');
                                          getSort('Lowest price', 0, 0);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      CheckboxListTile(
                                        title: Text('Highest guest rating'),
                                        value: cubit.selectedSort
                                            .contains('Highest guest rating'),
                                        onChanged: (value) {
                                          cubit.toggleSort(
                                              'Highest guest rating');
                                          getSort('Highest guest rating', 0, 0);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      CheckboxListTile(
                                        title: Text('Distance from center'),
                                        value: cubit.selectedSort
                                            .contains('Distance from center'),
                                        onChanged: (value) {
                                          cubit.toggleSort(
                                              'Distance from center');
                                          getSort('Distance from center', 0, 0);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        child: Row(children: [
                          Icon(Icons.swap_vert),
                          RSizedBox(
                            width: 7,
                          ),
                          Text("Sort by"),
                        ]),
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 25,
                      color: Colors.black45,
                    ),
                    RPadding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),

                       child: GestureDetector(
                          onTap: () async {
                            getHotel();
                            avg.sort();
                            Map<String, dynamic>? result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FilterSecreen(
                                  minPrice: avg[0],
                                  maxPrice: avg[avg.length - 1],
                                ),
                              ),
                            );

                            if (result != null) {
                              int selectedNumStar = result['numStar'];
                              double priceFilter = result['price'];
                              await getSort("Filter", selectedNumStar, priceFilter);

                            }
                          },
                          child: Row(
                            children: [
                              Icon(Icons.sort),
                              SizedBox(width: 7),
                              Text("Filters"),
                            ],
                          ),
                        ),


                      ),
                    ),
                    Container(
                      width: 1,
                      height: 25,
                      color: Colors.black45,
                    ),
                    RPadding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MapSecreen(city: widget.city,
                                country: widget.country,avg: avg,hotel: hotel),
                            )),
                        child: Row(children: [
                          Icon(Icons.map_outlined),
                          RSizedBox(
                            width: 7,
                          ),
                          Text("Map")
                        ]),
                      ),
                    ),
                  ],
                ),
                RPadding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: 550,
                      child: isInternetConnected
                          ? hotel.isNotEmpty
                              ? ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: hotel.length,
                                  itemBuilder: (context, i) {
                                    return InkWell(
                                        onTap: () {
                                          var imagesHotel = [
                                            "${hotel[i]['image']}",
                                            "${hotel[i]['image1']}",
                                            "${hotel[i]['image2']}",
                                            "${hotel[i]['image3']}",
                                            "${hotel[i]['image4']}",
                                            "${hotel[i]['image5']}",
                                          ];
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) {
                                              return Hotel(
                                                cityHotel:
                                                    "${hotel[i]['city']}",
                                                nameHotel:
                                                    "${hotel[i]['name']}",
                                                image: imagesHotel,
                                                star: hotel[i]['star'],
                                                edit: false,
                                              );
                                            },
                                          ));
                                        },
                                        child: Card(
                                          clipBehavior: Clip.antiAlias,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.r),
                                            // side: BorderSide(color: Colors.),
                                          ),
                                          child: Row(children: [
                                            Image(
                                              image: NetworkImage(
                                                "${hotel[i]['image']}",
                                              ),
                                              height: 280.h,
                                              width: 125.w,
                                              fit: BoxFit.fitHeight,
                                            ),
                                            RSizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${hotel[i]['name']}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                Row(
                                                  children: [
                                                    Card(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(6.0),
                                                        child: Text(
                                                          "Hotel",
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                      color: Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7)),
                                                    ),
                                                    RSizedBox(
                                                      width: 2,
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                      width: 100,
                                                      child:
                                                          SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: Row(
                                                          children: [
                                                            ListView.builder(
                                                                scrollDirection:
                                                                    Axis
                                                                        .horizontal,
                                                                itemCount:
                                                                    hotel[i][
                                                                        'star'],
                                                                shrinkWrap:
                                                                    true,
                                                                itemBuilder:
                                                                    (context,
                                                                        index) {
                                                                  return Icon(
                                                                      Icons
                                                                          .star,
                                                                      size: 14,
                                                                      color: Colors
                                                                          .yellow);
                                                                }),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        Positioned(
                                                            child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            color: Colors.green,
                                                            width: 30.w,
                                                            height: 24.h,
                                                          ),
                                                        )),
                                                        Positioned(
                                                            left: 12.w,
                                                            top: 12.h,
                                                            child: Center(
                                                              child: Text(
                                                                "${hotel[i]['evaluation']}",
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ))
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Excellent",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.green,
                                                          ),
                                                        ),
                                                        RSizedBox(
                                                          width: 8,
                                                        ),
                                                        Text(
                                                            "${hotel[i]['Rate']} rating",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .grey)),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  "${hotel[i]['distance']} km from city centre of ${hotel[i]['city']}",
                                                  style: TextStyle(
                                                      color: Colors.black45,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 13),
                                                ),
                                                Card(
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r)),
                                                  color: Color.fromARGB(
                                                      255, 238, 255, 239),
                                                  //color: Colors.green,
                                                  child: RPadding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: Column(
                                                      children: [
                                                        Text("Free cacellation",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .green,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 16)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Card(
                                                  elevation: 0,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.r)),
                                                  color: lightColorScheme
                                                      .secondaryContainer,
                                                  //color: Colors.green,
                                                  child: RPadding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: Visibility(
                                                      visible:
                                                          "${hotel[i]['covid']}" !=
                                                              "no",
                                                      child: Text(
                                                        "COVID-19 safety info",
                                                        style: TextStyle(
                                                            color:
                                                                lightColorScheme
                                                                    .primary,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                RSizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    RSizedBox(
                                                      width: 100,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        avg[i] == 0.0
                                                            ? Container(
                                                                child: Center(
                                                                  child:
                                                                      SpinKitCircle(
                                                                    color: Colors
                                                                        .blue,
                                                                    size: 15.0,
                                                                  ),
                                                                ),
                                                              )
                                                            : Text(
                                                                "${avg[i].toStringAsFixed(2)}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      16.sp,
                                                                  color: lightColorScheme
                                                                      .primary,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                        Text(
                                                          "Total for 1 night",
                                                          style: TextStyle(
                                                              fontSize: 16.sp,
                                                              color: Colors
                                                                  .black45,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ]),
                                        ));
                                  })
                              : Center(
                                  child: SpinKitWanderingCubes(
                                    color: Colors.blue,
                                    size: 50.0,
                                  ),
                                )
                          : NoInternetSecreen(
                              onRetry: () {
                                checkInternetAvailability();
                              },
                            )),
                ),
              ]),
            ]));
      },
    );
  }
}
