import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../commen/theme/light_color_schema.dart';

Widget defaultTextFieldSection(
    {IconData? prefixIcon,
    String? labelText,
    Color? fillColor,
    VoidCallback? function,
    TextInputType? keyboardType,
    TextEditingController? controller,
    String? Function(String?)? validator,
    Function(dynamic value)? onChanged,
    Function(String)? onFieldSubmitted}){
  final focusNode = FocusNode();
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: 15,
    ),
    child: TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      focusNode: focusNode,
      onChanged: onChanged,
      onTap: function,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillColor,
        enabled: true,
        labelText: labelText,
        contentPadding:
            REdgeInsets.only(left: 14.0, right: 14, top: 10, bottom: 5),
        labelStyle: TextStyle(color: Colors.black45),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: focusNode.hasFocus ? Icon(Icons.clear) : null,
// prefixIcon: Icon(Icons.group),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: lightColorScheme.primary,
            )),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Color(0XFF1baedf))),
      ),
      keyboardType: keyboardType,
    ),
  );
}
