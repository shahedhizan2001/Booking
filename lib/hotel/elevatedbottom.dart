import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget defaultElevatedBottom({
  IconData? icons,
  String? title,
  required VoidCallback onPressed,
  required EdgeInsetsGeometry padding,
  Color? colors,
  Color? onPrimary,
  Color? backgroundColor,
  Size? size,
  OutlinedBorder? shape,
  Color? colorSide,
}) {
  return Padding(
    padding: padding,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: icons != null,
              child: Icon(
                icons,
                color: colors,
              ),
            ),
            Visibility(
              visible: icons == null,
              child: Container(),
            ),
            Visibility(
              visible: icons != null && title != null,
              child: RSizedBox(width: 10),
            ),
            Flexible(
              child: Text(
                title ?? '',
                style: TextStyle(
                  color: colors,
                  fontSize: 16.sp,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: backgroundColor,
        onPrimary: onPrimary,
        elevation: 0,
        fixedSize: size,
        shape: shape,
        side: BorderSide(color: colorSide ?? Colors.white),
      ),
    ),
  );
}