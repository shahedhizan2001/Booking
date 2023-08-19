import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
appBar(
    {Color? color,
    Color? backgroundColor,
    FontWeight? font,
    bool? centre,
      Widget?leading,
      double ?fontSize,
    required String title,
    FontWeight? weight,
      bool ?automaticallyImplyLeading,
    PreferredSizeWidget? bottom}) {
  return AppBar(
    leading: leading,
    bottom: bottom,
    backgroundColor: backgroundColor,
    automaticallyImplyLeading: automaticallyImplyLeading??true,
    title: Text(
      title,
      style: TextStyle(color: Colors.black, fontWeight: font, fontSize: 21.sp) ,
    ),
    centerTitle: centre,
    iconTheme: IconThemeData(color: color, size: 22.sp),
  );
}
