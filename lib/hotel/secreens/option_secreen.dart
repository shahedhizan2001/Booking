import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../commen/theme/light_color_schema.dart';
import '../app_bar.dart';
import '../elevated/hotel_secreen_cubit.dart';
import '../elevated/hotel_secreen_state.dart';
import '../elevatedbottom.dart';

class OptionSecreen extends StatelessWidget {
  const OptionSecreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = ExpandableController();
    return BlocBuilder<HotelSecreenCubit, HotelSecreenStates>(
      builder: (context, state) {
        HotelSecreenCubit cubit = HotelSecreenCubit.get(context);
        return Scaffold(
          appBar: appBar(title: "Guest", centre: true, font: FontWeight.w500),
          body: ListView(children: [
            RPadding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                "Maximum number of guests per room is 4",
                style: TextStyle(fontSize: 14.sp),
              )),
            ),
            RPadding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: ExpandableNotifier(
                  child: Builder(builder: (context) {
                    return Column(children: [
                      Container(
                        width: double.maxFinite,
                        height: 50.h,
                        color: Colors.white10,
                        child: Row(
                          children: [
                            RPadding(
                              padding: const EdgeInsets.only(left: 9),
                              child: Icon(
                                Icons.bed_rounded,
                                size: 20.sp,
                              ),
                            ),
                            RSizedBox(
                              width: 10,
                            ),
                            Text(
                              "Room 1",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      RPadding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Adults",
                                  style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text("Age(12+)")
                              ],
                            ),
                            RSizedBox(
                              width: 150.w,
                            ),
                            IconButton(
                                onPressed: () {
                                  cubit.decrementA();
                                },
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  color: lightColorScheme.primary,
                                  size: 30.sp,
                                )),
                            Text(
                              '${cubit.countA1}',
                              style: TextStyle(fontSize: 20.sp),
                            ),
                            IconButton(
                                onPressed: () {
                                  cubit.incrementA();
                                },
                                icon: Icon(
                                  Icons.add_circle_outline,
                                  color: lightColorScheme.primary,
                                  size: 30.sp,
                                )),
                          ],
                        ),
                      ),
                      Container(
                        height: 1.h,
                        color: Colors.black12,
                      ),
                      RPadding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Children",
                                  style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text("Age(0-11)")
                              ],
                            ),
                            RSizedBox(
                              width: 150,
                            ),
                            IconButton(
                                onPressed: () {
                                  cubit.decrementC(cubit.selectedAge1.last);
                                  cubit.istoggleA(context: context);
                                },
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  color: lightColorScheme.primary,
                                  size: 30.sp,
                                )),
                            Text(
                              '${cubit.selectedAge1.length}',
                              style: TextStyle(fontSize: 20.sp),
                            ),
                            Builder(
                              builder: (BuildContext context) {
                                return IconButton(
                                    onPressed: () {
                                      cubit.showButtomsheetA(context: context);
                                      cubit.istoggleA(context: context);
                                    },
                                    icon: Icon(
                                      Icons.add_circle_outline,
                                      color: lightColorScheme.primary,
                                      size: 30.sp,
                                    ));
                              },
                            ),
                          ],
                        ),
                      ),
                      RPadding(
                        padding: const EdgeInsets.all(8.0),
                        child: Expandable(
                            collapsed: SizedBox.shrink(),
                            expanded: cubit.displayChildrenA()),
                      ),
                    ]);
                  }),
                ),
              ),
            ),
            Visibility(
              visible: cubit.isButtonVisible,
              child: defaultElevatedBottom(
                title: "add another room",
                icons: Icons.add_circle,
                onPressed: () {
                  cubit.isCardVisibility();
                  cubit.isButtonVisibility();
                },
                padding: EdgeInsets.all(12.0),
                colors: lightColorScheme.primary,
                backgroundColor: Colors.white,
                colorSide: lightColorScheme.primary,
                onPrimary: lightColorScheme.primary,
                size: Size(200.w, 45.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                    side: BorderSide(
                      color: lightColorScheme.primary,
                    )),
              ),
            ),
            Visibility(
              visible: cubit.isCardVisible,
              child: RPadding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ExpandableNotifier(
                    child: Builder(builder: (context) {
                      return Column(children: [
                        Container(
                          width: double.maxFinite,
                          height: 50,
                          color: Colors.white10,
                          child: Row(
                            children: [
                              RPadding(
                                padding: const EdgeInsets.only(left: 9),
                                child: Icon(
                                  Icons.bed_rounded,
                                  size: 20.sp,
                                ),
                              ),
                              RSizedBox(
                                width: 10,
                              ),
                              Text(
                                "Room 2",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              RSizedBox(
                                width: 180,
                              ),
                              TextButton(
                                  onPressed: () {
                                    cubit.isCardNotVisibility();
                                    cubit.isButtonVisibility();
                                    cubit.countA2 = 0;
                                    cubit.selectedAge2.length = 0;
                                  },
                                  child: Text(
                                    "Remove",
                                    style: TextStyle(
                                        color: lightColorScheme.error,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ],
                          ),
                        ),
                        RPadding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Adults",
                                    style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text("Age(12+)")
                                ],
                              ),
                              RSizedBox(
                                width: 150.w,
                              ),
                              IconButton(
                                  onPressed: () {
                                    cubit.decrementB();
                                  },
                                  icon: Icon(
                                    Icons.remove_circle_outline,
                                    color: lightColorScheme.primary,
                                    size: 30.sp,
                                  )),
                              Text(
                                '${cubit.countA2}',
                                style: TextStyle(fontSize: 20.sp),
                              ),
                              IconButton(
                                  onPressed: () {
                                    cubit.incrementB();
                                  },
                                  icon: Icon(
                                    Icons.add_circle_outline,
                                    color: lightColorScheme.primary,
                                    size: 30.sp,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          height: 1.h,
                          color: Colors.black12,
                        ),
                        RPadding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Children",
                                    style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text("Age(0-11)")
                                ],
                              ),
                              RSizedBox(
                                width: 150,
                              ),
                              IconButton(
                                  onPressed: () {
                                    cubit.decrementD(cubit.selectedAge2.last);
                                    cubit.istoggleB(context: context);
                                  },
                                  icon: Icon(
                                    Icons.remove_circle_outline,
                                    color: lightColorScheme.primary,
                                    size: 30.sp,
                                  )),
                              Text(
                                '${cubit.selectedAge2.length}',
                                style: TextStyle(fontSize: 20.sp),
                              ),
                              Builder(
                                builder: (BuildContext context) {
                                  return IconButton(
                                      onPressed: () {
                                        cubit.showButtomsheetB(
                                            context: context);
                                        cubit.istoggleB(context: context);
                                      },
                                      icon: Icon(
                                        Icons.add_circle_outline,
                                        color: lightColorScheme.primary,
                                        size: 30.sp,
                                      ));
                                },
                              ),
                            ],
                          ),
                        ),
                        RPadding(
                          padding: const EdgeInsets.all(8.0),
                          child: Expandable(
                              collapsed: SizedBox.shrink(),
                              expanded: cubit.displayChildrenB()),
                        ),
                      ]);
                    }),
                  ),
                ),
              ),
            ),
            defaultElevatedBottom(onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
            }, padding: const EdgeInsets.all(12.0),
              title: "Apply",size: Size(200.w, 45.h),
            )
          ]),
        );
      },
    );
  }
}
