import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_bar.dart';

class ImageHotel extends StatelessWidget {
   ImageHotel({Key? key,required this.imagesHotel}) : super(key: key);
  List imagesHotel  = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: "Photos",
      ),
      body: RPadding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 3.w,
          mainAxisSpacing: 3.h,
          children: [
            GestureDetector(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                //   return ImageSecreen(images: )
                // },));
               // Navigator.pushNamed(context, 'ImageRoom');
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Image(
                    image: NetworkImage(
                        "${imagesHotel[0]}"),
                    fit: BoxFit.cover),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image(
                  image: NetworkImage(
                      "${imagesHotel[1]}"),
                  fit: BoxFit.cover),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image(
                  image: NetworkImage(
                      "${imagesHotel[2]}"),
                  fit: BoxFit.cover),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image(
                  image: NetworkImage(
                      "${imagesHotel[3]}"),
                  fit: BoxFit.cover),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image(
                  image: NetworkImage(
                      "${imagesHotel[4]}"),
                  fit: BoxFit.cover),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image(
                  image: NetworkImage(
                      "${imagesHotel[5]}"),
                  fit: BoxFit.cover),
            ),

          ],
        ),
      ),
    );
  }
}
