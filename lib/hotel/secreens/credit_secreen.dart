import 'package:booking/hotel/secreens/select_room.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../commen/theme/light_color_schema.dart';
import '../../screens/Finish_page.dart';
import '../app_bar.dart';
import '../elevatedbottom.dart';
import '../textfield.dart';
import 'Booking.dart';
import 'booking_hotel.dart';

class CreditSecreen extends StatefulWidget {
  CreditSecreen({super.key, this.selectedPayments,this.total1,required  this.condition});
  bool condition;
  int? total1;
  final selectedPayments;
  @override
  State<CreditSecreen> createState() => _CreditSecreenState();
}

class _CreditSecreenState extends State<CreditSecreen> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _cardNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Payment", centre: true,),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RPadding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total to be paid",
                          style: TextStyle(
                              fontSize: 15.sp,
                              color: Colors.black45,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          "\$ ${totalPrice}",
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    RSizedBox(
                      width: 50,
                    ),
                    TextButton(
                        onPressed: () {
                          if(widget.condition){
                            print("ooooooooooooooooooooooooooooooo");
                            print(widget.condition);
                            Navigator.pop(context);
                          }else{
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              return FinishPage();
                            },));
                          }

                        },
                        child: Text(
                          "VIEW BOOKING SUMMURY",
                          style: TextStyle(fontSize: 14),
                        ))
                  ],
                ),
              ),
              Container(
                height: 1,
                color: Colors.black45,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.safety_check_outlined,
                          color: Colors.green,
                        ),
                        RSizedBox(
                          width: 10,
                        ),
                        Text(
                          "WE PROTECT YOUR PERSONAL INFORMATION",
                          style: TextStyle(fontSize: 13, color: Colors.green),
                        )
                      ],
                    )),
              ),
              defaultTextFieldSection(
                controller: _cardNumberController,
                labelText: "Card number",
                keyboardType: TextInputType.number,
                fillColor: lightColorScheme.onPrimary,
                validator: (value) {
                  if (value!.isEmpty) {
                    return '';
                  }
                  return null;
                },
              ),
              RSizedBox(
                height: 10,
              ),
              defaultTextFieldSection(
                labelText: "Name on card",
                function: () {
                },
                controller: _cardNameController,
                keyboardType: TextInputType.name,
                fillColor: lightColorScheme.onPrimary,
                validator: (value) {
                  if (value!.isEmpty) {
                    return '';
                  }
                  return null;
                },
              ),
              Center(
                child: defaultElevatedBottom(
                    onPressed: () {
                      addReservationHotel();
                      print("done");
                      if (_formkey.currentState!.validate()) {
                        // perform payment submission here
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return BookingHotel();
                        },));
                      }

                    },
                    padding: EdgeInsets.all(12),
                    title: "Pay now",
                    icons: Icons.payment,
                    size: Size(350.w, 45.h)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
