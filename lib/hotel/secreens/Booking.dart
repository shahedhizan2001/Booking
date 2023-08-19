import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_bar.dart';
import 'booking_flight.dart';
import 'booking_hotel.dart';


class Booking extends StatefulWidget {
   Booking({super.key,this.selectedPayments});
   final selectedPayments;

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: appBar(title: "Booking Summury",
            centre: true,
            bottom: const TabBar(
              tabs: [
                Tab(
                  child: Text('Flight',style: TextStyle(color: Colors.black)),
                ),
                Tab(
                  child: Text('Hotel',style: TextStyle(color: Colors.black)),
                )
              ],
            )
        ),
        body: TabBarView(
          children: [
            BookingFlight(),
            BookingHotel(),
          ],
        ),
      ),
    );
  }
}