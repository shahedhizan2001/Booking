import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

stackImage1(
    {required String image,
     required String title,
    double? h1,
      double? h2,
    double? w,
    double? t1,
      double? t2,
    double? b,
    double? l,
    double? r,
      VoidCallback ?funcyion
    }) {
  return Stack(
    children: [
      Positioned(
        top: t1,
        child: GestureDetector(
          onTap: funcyion,
          child: Container(
              child: Image(
            image:NetworkImage(image),
            fit: BoxFit.cover,
            height: h1,
                width: 150,
          )) ,

        ),
      ),
      Positioned(
        bottom: b,
          left: l,
          top: t2,
          right: r,
          child: Container(
              height: h2,
              width: w,
              color: Colors.black12,
              child: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white),
                  ),
                  Icon(
                    Icons.camera_enhance_sharp,
                    color: Colors.white,
                  ),
                ],
              ))),

    ],
  );
}

stackImage2(
    {required String image,
      required String title,
      int? star,
      double? h1,
      double? h2,
      double? w,
      double? t1,
      double? t2,
      double? b,
      double? l,
      double? r,
      String? text,
      required VoidCallback function
    }) {
  return Stack(
    children: [
      Positioned(
        top: t1,
        child: GestureDetector(
          onTap:function ,
          child: Container(
              child: Image(
                image: NetworkImage(image),
                fit: BoxFit.cover,
                width: 400,
                height: h1,
              )),
        ),
      ),
      Positioned(
          bottom: b,
          left: l,
          top: t2,
          right: r,
          child: Container(
              height: h2,
              width: w,
              color: Colors.black12,
              child: Row(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white),
                  ),
                  Icon(
                    Icons.camera_enhance_sharp,
                    color: Colors.white,
                  ),
                ],
              ))),
        Positioned(bottom: 30.h,
            child: RPadding(
              padding: const EdgeInsets.all(8.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,

          children: [
              Text(text!,style: TextStyle(color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),),
            Row(
              children: [
                Card(child:Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text("Hotel",textAlign: TextAlign.center,
                  ),
                ),color: Colors.white,


                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7)
                ),
                ),
                RSizedBox(width: 2,),

                SizedBox(
                  height: 20,
                  width: 100,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: star,
                            shrinkWrap: true,
                            itemBuilder: (context , index){
                              return  Icon(Icons.star,
                                  size: 14, color: Colors.yellow) ;
                            }
                        ) ,

                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
            )),
    ],
  );
}
