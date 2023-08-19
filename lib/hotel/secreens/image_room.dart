import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../commen/theme/light_color_schema.dart';
import '../app_bar.dart';
import '../elevated/hotel_secreen_cubit.dart';
import '../elevated/hotel_secreen_state.dart';

class ImageSecreen extends StatelessWidget {
   ImageSecreen({Key? key, required this.images}) : super(key: key);
   List images = [];
  int _selectedImageIndex=0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelSecreenCubit,HotelSecreenStates>(
      builder: (context, state) {
        HotelSecreenCubit cubit = HotelSecreenCubit.get(context);
        return  Scaffold(
          backgroundColor:lightColorScheme.onPrimaryContainer,
          appBar: appBar(
            backgroundColor: Color(0xFF006685),
              color: Colors.white, title: "",
          ),
          body: Column(
            children: [
              Center(
                child: Container(
                  height: 500.h,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            "${images[_selectedImageIndex]}"),
                      )),
                ),
              ),
              Container(
                  color:lightColorScheme.secondary,
                  height: 80.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                     return  GestureDetector(
                        onTap: () {
                          _selectedImageIndex = index;
                         cubit.updateSelectedImageIndex(_selectedImageIndex);
                        },
                        child: Card(
                          child: Image(
                            image: NetworkImage(
                                "${images[index]}"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ))
            ],
          ),
        );
      },

    );
  }
}
