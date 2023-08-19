import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_bar.dart';
import '../elevated/hotel_secreen_cubit.dart';
import '../elevated/hotel_secreen_state.dart';
import '../elevatedbottom.dart';
class FilterSecreen extends StatefulWidget {
  FilterSecreen({Key? key, this.maxPrice, this.minPrice});

  final double? maxPrice;
  final double? minPrice;

  @override
  State<FilterSecreen> createState() => _FilterSecreenState();
}

class _FilterSecreenState extends State<FilterSecreen> {
  int numStar = 0;
  double priceSelect = 0.0;

  @override
  void initState() {
    super.initState();
    getPriceSelect().then((value) {
      setState(() {
        priceSelect = value;
      });
    });
  }
  Future<double> getPriceSelect() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? price = prefs.getDouble('priceSelect');
    return price ?? widget.maxPrice ?? 0.0;
  }
  void savePriceSelect(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('priceSelect', value);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelSecreenCubit, HotelSecreenStates>(
      builder: (context, state) {
        HotelSecreenCubit cubit = HotelSecreenCubit.get(context);
        return Scaffold(
          appBar: appBar(
            title: "Filters",
            centre: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.close,
                size: 28.sp,
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RPadding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Price",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
              ),
              Slider(
                value: priceSelect,
                min: widget.minPrice ?? 580,
                max: widget.maxPrice ?? 6800,
                onChanged: (value) {
                  setState(() {
                    priceSelect = value;
                    savePriceSelect(value);

                  });
                },
              ),
              RPadding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text("${widget.minPrice?.toInt()}"),
                    ),
                    RSizedBox(
                      width: 270,
                    ),
                    Expanded(
                      child: Text('${priceSelect.round()}'),
                    ),
                  ],
                ),
              ),
              RPadding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Hotel rating",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
              ),
              CheckboxListTile(
                title: Text('5 Star'),
                value: cubit.selectedSort.contains('5'),
                onChanged: (value) {
                  cubit.toggleSort('5');
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              CheckboxListTile(
                title: Text('4 Star'),
                value: cubit.selectedSort.contains('4'),
                onChanged: (value) {
                  cubit.toggleSort('4');
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              CheckboxListTile(
                title: Text('3 Star'),
                value: cubit.selectedSort.contains('3'),
                onChanged: (value) {
                  cubit.toggleSort('3');
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              CheckboxListTile(
                title: Text('2 Star'),
                value: cubit.selectedSort.contains('2'),
                onChanged: (value) {
                  cubit.toggleSort('2');
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
            ],
          ),
          bottomNavigationBar: defaultElevatedBottom(
            onPressed: () {
              if (cubit.selectedSort.isEmpty)
                numStar = 0;
              else
                numStar = int.parse(cubit.selectedSort[0]);
              print("numStar $numStar");
              print(priceSelect);
              Navigator.pop(
                context,
                {
                  'numStar': numStar,
                  'price': priceSelect,
                },
              );
            },
            padding: REdgeInsets.all(12),
            title: "Show Hotels",
            size: Size.fromHeight(50),
          ),
        );
      },
    );
  }
}