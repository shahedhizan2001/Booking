import 'package:booking/hotel/secreens/select_room.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../commen/theme/light_color_schema.dart';
import '../app_bar.dart';
import '../elevated/hotel_secreen_cubit.dart';
import '../elevated/hotel_secreen_state.dart';
import '../stack_image.dart';
import 'hotel_details.dart';
import 'image_hotel.dart';
import 'no_internet_Secreen.dart';

class Hotel extends StatefulWidget {
  Hotel(
      {Key? key,
      this.nameHotel,
      this.cityHotel,
      required this.image,
      this.countryHotel,
      this.star,
      this.reservationId,
      this.userId,
      required this.edit})
      : super(key: key);
  String? nameHotel;
  String? cityHotel;
  String? countryHotel;
  List image;
  int? star;
  String? reservationId;
  String? userId;
  bool? edit;

  @override
  State<Hotel> createState() => _HotelState();
}

class _HotelState extends State<Hotel> {

  void _refreshPage() {
    setState(() {});
  }
  bool isInternetConnected = true;

  String? checkIn;
  String? checkOut;

  int? numNight;

  @override
  void initState() {
    // getAvgPrice();
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
          backgroundColor: Colors.white,
          appBar: appBar(
            title: "${widget.nameHotel}, ${widget.cityHotel}",
            fontSize: 17.sp,
            weight: FontWeight.w500,
            color: lightColorScheme.primary,
          ),
          body: isInternetConnected
              ? DefaultTabController(
                  length: 2,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      Container(
                        height: 200.h,
                        child: stackImage2(
                            image: "${widget.image[0]}",
                            title: "6",
                            star: widget.star,
                            t1: 0.h,
                            t2: 15.h,
                            h1: 180.h,
                            r: 10.w,
                            h2: 32.h,
                            w: 45.w,
                            function: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return ImageHotel(
                                    imagesHotel: widget.image,
                                  );
                                },
                              ));
                            },
                            text: "${widget.nameHotel}, ${widget.cityHotel}"),
                      ),
                      RPadding(
                        padding: const EdgeInsets.only(right: 4, left: 4),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                cubit.chooseDateRangePicker(context: context);
                              },
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        "Check in",
                                        style: TextStyle(color: Colors.black45),
                                      ),
                                      Text(
                                        DateFormat("dMMM")
                                            .format(cubit.dateRange.start)
                                            .toString(),
                                        style: TextStyle(
                                          color: lightColorScheme.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black12,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "Check Out",
                                        style: TextStyle(color: Colors.black45),
                                      ),
                                      Text(
                                        DateFormat("dMMM")
                                            .format(cubit.dateRange.end)
                                            .toString(),
                                        style: TextStyle(
                                          color: lightColorScheme.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                elevation: 0,
                                minimumSize: Size(0.w, 60.h),
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.black45),
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                            ),
                            RSizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextButton(
                                                    onPressed: () {
                                                      cubit.countA1 = 2;
                                                      cubit.num_room = 1;
                                                      cubit.countA2 = 0;
                                                      cubit.selectedAge1.length=0;
                                                      cubit.selectedAge2.length=0;

                                                      Navigator.pop(context);
                                                      cubit.selectFilter();
                                                    },
                                                    child: Text(
                                                      "1 Room, 2 Adults ,0 children",
                                                      style: TextStyle(
                                                          color: Colors.black45,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    )),
                                                TextButton(
                                                    onPressed: () {
                                                      cubit.countA1 = 1;
                                                      cubit.num_room = 1;
                                                      cubit.selectedAge1.length=0;
                                                      cubit.selectedAge2.length=0;
                                                      cubit.countA2 = 0;
                                                      Navigator.pop(context);
                                                      cubit.selectFilter();
                                                    },
                                                    child: Text(
                                                      "1 Room, 1 Adults ,0 children",
                                                      style: TextStyle(
                                                          color: Colors.black45,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    )),
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          'OptionSecreen');
                                                    },
                                                    child: Text(
                                                      "More options",
                                                      style: TextStyle(
                                                          color: Colors.black45,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ))
                                              ],
                                            ),
                                          ));
                                },
                                child: Text(
                                  cubit.countA1 == 0
                                      ? "you must be choose number of guest"
                                      : '${cubit.num_room}Room,'
                                          ' ${cubit.countA1 + cubit.countA2} Adults ,'
                                          '${cubit.selectedAge1.length + cubit.selectedAge2.length} children',
                                  style: TextStyle(color: Colors.black45),
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
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: double.maxFinite,
                            height: 30.h,
                            child: TabBar(labelColor: Colors.black, tabs: [
                              Tab(text: "Select room"),
                              Tab(text: "Hotel details"),
                            ])),
                      ),
                      Container(
                        //width: double.maxFinite,
                        height: 300.h,

                        child: TabBarView(children: [
                          RoomSection(
                              nameHotel: "${widget.nameHotel}",
                              country: "${widget.countryHotel}",
                              city: "${widget.cityHotel}",
                              image: widget.image,
                              star: widget.star,
                              checkIn: DateFormat("d MMM, yyyy")
                                  .format(cubit.dateRange.start)
                                  .toString(),
                              checkOut: DateFormat("d MMM, yyyy")
                                  .format(cubit.dateRange.end)
                                  .toString(),
                              numNight: int.parse(DateFormat("d")
                                      .format(cubit.dateRange.end)) -
                                  int.parse(DateFormat("d")
                                      .format(cubit.dateRange.start)),
                              edit: widget.edit,
                              reservationId: widget.reservationId),
                          HotelDetails(nameHotel: "${widget.nameHotel}",city: widget.cityHotel),
                        ]),
                      )
                    ],
                  ),
                )
              : NoInternetSecreen(
                  onRetry: () {
                    checkInternetAvailability();
                  },
                ),
        );
      },
    );
  }
}
