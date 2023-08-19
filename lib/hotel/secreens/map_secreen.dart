import 'dart:async';
import 'package:booking/hotel/secreens/room_in_hotel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../commen/theme/light_color_schema.dart';
import '../elevated/hotel_secreen_cubit.dart';
import '../elevated/hotel_secreen_state.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:flutter/services.dart';
import 'dart:collection';
import 'dart:typed_data';
import 'dart:ui';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapSecreen extends StatefulWidget {
  MapSecreen(
      {Key? key,
      this.city,
      this.country,
      required this.avg,
      required this.hotel});

  String? city;
  String? country;
  List<double> avg;
  List hotel;

  @override
  State<MapSecreen> createState() => _MapSecreenState();
}

class _MapSecreenState extends State<MapSecreen> {
  CollectionReference refC = FirebaseFirestore.instance.collection("nation");
  int? select;

  List<Map<String, dynamic>> city = [];
  var myMarkers = HashSet<Marker>();
  Marker? selectedMarker;
  Completer<GoogleMapController> _controller = Completer();

  getCity() async {
    await refC.where("city", isEqualTo: "${widget.city}").get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          city.add(element.data() as Map<String, dynamic>);
        });
      });
    });
  }

  @override
  void initState() {
    getCity();

    super.initState();
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
                    fontSize: 18,
                  ),
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
                        fontSize: 16,
                      ),
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
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "-",
                          style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          DateFormat("dd/MM")
                              .format(cubit.dateRange.end)
                              .toString(),
                          style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.attach_money_rounded),
              ),
            ],
          ),
          body: Stack(children: [
            GoogleMap(
              zoomControlsEnabled: false,
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(city[0]['x'], city[0]['y']), //city
                zoom: 5.5,
              ),
              onMapCreated: (GoogleMapController controller) async {
                for (int i = 0; i < widget.hotel.length; i++) {
                  final byteData = await _createCustomMarkerBytes(
                      widget.avg[i].toStringAsFixed(2));
                  final d = BitmapDescriptor.fromBytes(byteData);

                  setState(() {
                    myMarkers.add(
                      Marker(
                        markerId: MarkerId('$i'),
                        position: LatLng(
                            widget.hotel[i]['x']!, widget.hotel[i]['y']!),
                        icon: d,
                        onTap: () {
                          setState(() {
                            select = i;
                            print("select $select");
                            selectedMarker = Marker(
                                markerId: MarkerId('$i'),
                                position: LatLng(widget.hotel[i]['x'],
                                    widget.hotel[i]['y']));
                          });
                        },
                      ),
                    );
                  });
                }

                _controller.complete(controller);
              },
              markers: myMarkers,
            ),
            if (selectedMarker != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Hotel(
                            cityHotel: widget.city,
                            nameHotel: widget.hotel[select!]['name'],
                            edit: false,
                            star: widget.hotel[select!]['star'],
                            image: [
                              widget.hotel[select!]['image'],
                              widget.hotel[select!]['image1'],
                              widget.hotel[select!]['image2'],
                              widget.hotel[select!]['image3'],
                              widget.hotel[select!]['image4'],
                              widget.hotel[select!]['image5'],
                            ],

                          ),
                        ));
                      },
                      child: Card(
                        child: Row(
                          children: [
                            Container(
                              child: Image(
                                image: NetworkImage(
                                    "${widget.hotel[select!]['image']}"),
                                fit: BoxFit.cover,
                                height: 220,
                                width: 80,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${widget.hotel[select!]['name']}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Row(
                                    children: [
                                      Card(
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text(
                                            "Hotel",
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      SizedBox(
                                        height: 20,
                                        width: 100,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: widget
                                                      .hotel[select!]['star'],
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Icon(Icons.star,
                                                        size: 14,
                                                        color: Colors.yellow);
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
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              color: Colors.green,
                                              width: 30,
                                              height: 24,
                                            ),
                                          )),
                                          Positioned(
                                              left: 12,
                                              top: 12,
                                              child: Center(
                                                child: Text(
                                                  "${widget.hotel[select!]['evaluation']}",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${widget.hotel[select!]['class']}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                              "${widget.hotel[select!]['Rate']} rating",
                                              style: TextStyle(
                                                  color: Colors.grey)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    color: Color.fromARGB(255, 238, 255, 239),
                                    //color: Colors.green,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text("Free cacellation",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16)),
                                    ),
                                  ),
                                  Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    color: lightColorScheme.primaryContainer,
                                    //color: Colors.green,
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Visibility(
                                        visible:
                                            "${widget.hotel[select!]['covid']}" !=
                                                "no",
                                        child: Text(
                                          "COVID-19 safety info",
                                          style: TextStyle(
                                              color: lightColorScheme.primary,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      RSizedBox(
                                        width: 120,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            "${widget.avg[select!].toStringAsFixed(2)} Sy",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: lightColorScheme.primary,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Total for 1 night",
                                            style: TextStyle(
                                                fontSize: 16.sp,
                                                color: Colors.black45,
                                                fontWeight: FontWeight.normal),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ]),
        );
      },
    );
  }
}

Future<Uint8List> _createCustomMarkerBytes(String title) async {
  final double markerWidth = 100.0;
  final double markerHeight = 50.0;
  final PictureRecorder pictureRecorder = PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);
  final Paint markerPaint = Paint()..color = lightColorScheme.primary;
  final TextPainter textPainter = TextPainter(
    textDirection: TextDirection.ltr,
  );

  // رسم المستطيل
  canvas.drawRect(
    Rect.fromLTWH(0, 0, markerWidth, markerHeight),
    markerPaint,
  );

  // رسم النص
  textPainter.text = TextSpan(
    text: title,
    style: TextStyle(
      color: Colors.white,
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    ),
  );
  textPainter.layout();
  textPainter.paint(
    canvas,
    Offset(markerWidth / 2 - textPainter.width / 2,
        markerHeight / 2 - textPainter.height / 2),
  );

  final picture = pictureRecorder.endRecording();
  final image =
      await picture.toImage(markerWidth.toInt(), markerHeight.toInt());
  final byteData = await image.toByteData(format: ImageByteFormat.png);

  return byteData!.buffer.asUint8List();
}
