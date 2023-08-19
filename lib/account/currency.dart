import 'package:booking/hotel/elevated/hotel_secreen_cubit.dart';
import 'package:booking/hotel/elevated/hotel_secreen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../hotel/app_bar.dart';

class CurrencyListPage extends StatelessWidget {
  CurrencyListPage();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelSecreenCubit, HotelSecreenStates>(
      builder: (context, state) {
        HotelSecreenCubit cubit = HotelSecreenCubit.get(context);
        return Scaffold(
          appBar: appBar(title: "Currency List"),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              TextButton(
                  onPressed: () {
                    cubit.changeCurrency("USD");
                    Navigator.pop(context);
                  },
                  child: Text(
                    "USD",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  )),
              TextButton(
                  onPressed: () {
                    cubit.changeCurrency("SYP",);
                    Navigator.pop(context);
                  },
                  child: Text('SYP',style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),))
            ]),
          ),
          // body: ListView.builder(
          //   itemCount: cubit.selectedCurrency.length,
          //   itemBuilder: (context, index) {
          //     return ListTile(
          //       title: Text(cubit.selectedCurrency[index]),
          //       onTap: () {
          //         Navigator.pop(context, cubit.selectedCurrency[index]);
          //       },
          //     );
          //   },
          // ),
        );
      },
    );
  }
}
