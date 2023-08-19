
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../custms/calenderD.dart';
import '../../screens/RegPage.dart';
import 'base_page.dart';

class BookingFlight extends StatefulWidget {
  @override
  State<BookingFlight> createState() => _BookingFlightState();
}

class _BookingFlightState extends State<BookingFlight> {
  List reservation = [];
  CollectionReference reservationRef =
      FirebaseFirestore.instance.collection("reservationFlight");
  bool isLoading = true;

  addReservationIdF() async {
    if (getUser() == null) {
      setState(() {
        reservation = [];
        isLoading = false;
      });
    } else {
      await reservationRef
          .where("userId", isEqualTo: getUser())
          .get()
          .then((value) {
        if (value.size > 0) {
          value.docs.forEach((element) {
            setState(() {
              reservation.add(element.data());
            });
          });
        }
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  void initState() {
    addReservationIdF();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : reservation.isEmpty
              ? Center(
                  child: Text('No reservation yet',style: TextStyle(fontSize: 20),),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemCount: reservation.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(16.0),
                      margin:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text("${reservation[index]['Departure']}"),
                                  Icon(Icons.flight_takeoff),
                                  SizedBox(
                                    height: 20,
                                    width: 30,
                                  ),
                                  Text("Date: ${reservation[index]['date']}"),
                                  SizedBox(
                                    height: 20,
                                    width: 30,
                                  ),
                                  Text("from: ${reservation[index]['from']}"),
                                ],
                              ),
                              SizedBox(width: 70.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("${reservation[index]['arrival']}"),
                                  Icon(Icons.flight_land),
                                  SizedBox(
                                    height: 20,
                                    width: 30,
                                  ),
                                  Text("Price: ${reservation[index]['price']}"),
                                  SizedBox(
                                    height: 20,
                                    width: 30,
                                  ),
                                  Text("to: ${reservation[index]['to']}")
                                ],
                              ),
                              SizedBox(width: 10.0),
                              Column(
                                children: [
                                  Text(
                                    '20',
                                    style: TextStyle(color: Colors.lightBlue),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      if (DateTime.parse(getDate()!)
                                          .isBefore(DateTime.now())) {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              AlertDialog(
                                                title: Text("Warning"),
                                                content: Text(
                                                    "The reservation cannot be modified because the reservation has expired."),
                                                actions: [
                                                  TextButton(
                                                    child: Text("OK"),
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context);
                                                    },
                                                  ),
                                                ],
                                              ),
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => RegPage(
                                              reservationId:
                                                  "${reservation[index]['reservationId']}",
                                              edit: true,
                                              from:
                                                  "${reservation[index]['from']}",
                                              to: "${reservation[index]['to']}",
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
