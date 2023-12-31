import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../hotel/app_bar.dart';
import '../hotel/elevated/hotel_secreen_cubit.dart';
import '../hotel/elevated/hotel_secreen_state.dart';
import '../hotel/secreens/booking_hotel.dart';
import '../hotel/secreens/credit_secreen.dart';
import '../hotel/secreens/select_room.dart';
import '../screens/Finish_page.dart';

class PaymentSelectionPage extends StatelessWidget {
  PaymentSelectionPage({this.total,required this.con});
  final int? total;
  bool con ;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelSecreenCubit, HotelSecreenStates>(
        builder: (context, state) {
          HotelSecreenCubit cubit=HotelSecreenCubit.get(context);
          return Scaffold(
            appBar: appBar(title: "Payment Selection", centre: true),
            body: ListView(
              children: <Widget>[
                CheckboxListTile(
                  title: Text('Credit card'),
                  value: cubit.selectedPayment.contains('Credit card'),
                  onChanged: (value) {
                    cubit.togglePayment('Credit card');
                  },
                ),
                CheckboxListTile(
                  title: Text('Cash'),
                  value: cubit.selectedPayment.contains('Cash'),
                  onChanged: (value) {
                    cubit.togglePayment('Cash');
                  },
                ),
                RPadding(
                  padding: const EdgeInsets.all(10),
                  child: ElevatedButton(
                    child: Text('Select', style: TextStyle(fontSize: 18),),
                    onPressed: () {
                      if (cubit.selectedPayment.contains('Credit card')) {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return CreditSecreen(
                              selectedPayments: cubit.selectedPayment,
                              total1: total,
                              condition: con,
                            );
                          }),
                        );
                      } else if (cubit.selectedPayment.contains('Cash')) {
                        //
                        // print("done");
                        if(con){
                          Navigator.pop(context);
                        }else{
                          addReservationHotel();
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                            return FinishPage();
                          },));
                        }



                      }

                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(100.w, 45.h),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

    );
  }
}

