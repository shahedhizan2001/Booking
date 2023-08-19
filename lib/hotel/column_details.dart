import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//bool? t3;
// void condition(){
//   if(title3 == false){
//     t3 = false;
//   }
// }
columnDetails({
  required var title1,
  required var title2,
  required var title3,
  required var title4,
  required var title5,
  required var title6,
  required IconData icon1,
  required IconData icon2,
  required IconData icon3,
  required IconData icon4,
  required IconData icon5,
}) {
//   void cond(){
//   if(title3 == false){
//     t3 = false;
//   }
//   else
//     t3 = true;
// }
// cond();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title1,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.5.sp),
      ),
      RSizedBox(
        height: 5,
      ),
      RSizedBox(
        height: 5,
      ),
      Row(
        children: [
          Visibility(
            visible: title3 != "no",
            child: Icon(
              icon1,
              color: Colors.black38,
            ),
          ),

          RSizedBox(
            width: 8.w,
          ),

          Visibility(
            visible: title3 != "no",
            child: Text(
              title3,
              style: TextStyle(color: Colors.black45),
            ),
          ),

        ],
      ),
      RSizedBox(
        height: 5,
      ),
      Row(
        children: [
          Visibility(
            visible: title2 != "no",
            child: Icon(
              icon5,
              color: Colors.black38,
            ),
          ),

          RSizedBox(
            width: 8.w,
          ),

          Visibility(
            visible: title2 != "no",
            child: Text(
              title2,
              style: TextStyle(color: Colors.black45),
            ),
          ),

        ],
      ),
      RSizedBox(
        height: 5,
      ),
      Row(
        children: [
          Visibility(
            visible: title4 != "no",
            child: Icon(
              icon2,
              color: Colors.black38,
            ),
          ),


          RSizedBox(
            width: 8.w,
          ),
          Visibility(
              visible: title4 != "no",
              child: Text(
                title4,
                style: TextStyle(color: Colors.black45),
              )),
          // Text(
          //   title4,
          //   style: TextStyle(color: Colors.black45),
          // )
        ],
      ),
      RSizedBox(
        height: 5,
      ),
      Row(
        children: [
          Icon(
            icon3,
            color: Colors.black38,
          ),
          RSizedBox(
            width: 8.w,
          ),
          Text(
            title5,
            style: TextStyle(color: Colors.black45),
          )
        ],
      ),
      RSizedBox(
        height: 5,
      ),
      Row(
        children: [
          Visibility(
            visible: title6 != "no",
            child: Icon(
              icon4,
              color: Colors.black38,
            ),
          ),
          RSizedBox(
            width: 8.w,
          ),
          Visibility(
              visible: title6 != "no",
              child: Text(
                title6,
                style: TextStyle(color: Colors.black45),
              ))
        ],
      ),
    ],
  );
}
