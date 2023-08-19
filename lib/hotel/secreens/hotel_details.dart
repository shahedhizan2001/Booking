import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class HotelDetails extends StatefulWidget {
  HotelDetails({Key? key, this.nameHotel,this.city}) : super(key: key);
  String? nameHotel;
  String? city;

  @override
  State<HotelDetails> createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  CollectionReference refC = FirebaseFirestore.instance.collection("nation");
  List<Map<String, dynamic>> city = [];
  GoogleMapController? gmc;

  getCity() async {
    await refC.where("city", isEqualTo: "${widget.city}").get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          city.add(element.data() as Map<String, dynamic>);
        });
      });
    });
    print(city);
  }
  var myMarkers = HashSet<Marker>();
  Marker? selectedMarker;

  CollectionReference ref = FirebaseFirestore.instance.collection("hotel");
  List detHotel = [];

  getDet() async {
    await ref.where("name", isEqualTo: widget.nameHotel).get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          detHotel.add(element.data());
        });
      });
    });
  }

  @override
  void initState() {
    getCity();
    getDet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: detHotel.isNotEmpty
          ? ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Column(
                    children: [
                      Container(
                          child: Stack(
                            children: [
                              Positioned(
                                child: Container(
                                  padding: REdgeInsets.all(8),
                                  height: 150,
                                  child: GoogleMap(
                                    zoomControlsEnabled: false,
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(city[0]['x'], city[0]['y']),
                                      zoom: 10.0,
                                    ),
                                    onMapCreated: (controller) {
                                      gmc = controller;
                                      setState(() async {
                                        myMarkers.add(
                                          Marker(
                                            markerId: MarkerId('1'),
                                            position: LatLng(
                                                detHotel[0]['x'], detHotel[0]['y']),
                                            onTap: () async {
                                              gmc!.animateCamera(
                                                  CameraUpdate.newCameraPosition(
                                                      CameraPosition(
                                                          target: LatLng(
                                                              detHotel[0]['x'], detHotel[0]['y']),
                                                          zoom: 16)));

                                            },
                                          ),
                                        );
                                      });
                                    },
                                    markers: Set<Marker>.from(myMarkers),
                                  ),
                                ),
                              )
                            ],
                          )),
                      RPadding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.grey),
                            RSizedBox(
                              width: 10,
                            ),
                            Text(
                              "${detHotel[0]['name']}, ${detHotel[0]['city']}",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                RPadding(
                  padding: const EdgeInsets.all(
                    8.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RPadding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Reviews",
                          style: TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 15.sp),
                        ),
                      ),
                      RPadding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(15.r)),
                          child: RPadding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Stack(
                                        children: [
                                          Positioned(
                                              child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              color: Colors.green,
                                              width: 30.w,
                                              height: 30.h,
                                            ),
                                          )),
                                          Positioned(
                                              left: 12.w,
                                              top: 14.h,

                                              child: Text(
                                                "${detHotel[0]['evaluation']}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ))
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${detHotel[0]['class']}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                          Text("${detHotel[0]['Rate']}, rating",
                                              style: TextStyle(
                                                  color: Colors.grey)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  RPadding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icons/medal-quality-svgrepo-com.svg",
                                          width: 30.w,
                                          height: 30.h,
                                        ),
                                        RSizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${detHotel[0]['class']} overall Ranking",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text("Top 7% in city")
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  RPadding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                        "${detHotel[0]['details']}"),
                                  ),
                                ]),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

              ],
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
