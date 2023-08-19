import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../screens/information_passport.dart';

class ResCustm extends StatefulWidget {
  ResCustm(
      {Key? key,
      required this.Departure,
      required this.arrival,
      required this.price,
      required this.date,
      required this.from,
      required this.to,this.reservationId, required this.edit})
      : super(key: key);
  String? Departure;
  String? arrival;
  int? price;
  String? date;
  String? from;
  String? to;
  String? reservationId;
  bool? edit;

  @override
  State<ResCustm> createState() => _ResCustmState();
}

class _ResCustmState extends State<ResCustm> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InfoPassportPage(
                    Departure: widget.Departure,
                    arrival: widget.arrival,
                    price: widget.price,
                  from:widget.from,
                  to:widget.to,
                    reservationId: widget.reservationId,
                  edit: widget.edit

                )));
      },
      child: Card(
        shadowColor: Colors.grey.withOpacity(0.7),
        elevation: 14,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 200, top: 10),
                child: Text(
                  'Qatar AirWays',
                  style: TextStyle(
                      fontSize: 18, color: Colors.black.withOpacity(0.7)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.Departure!,
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  SizedBox(
                    width: 100,
                  ),
                  Text(widget.arrival!,
                      style: TextStyle(fontSize: 20, color: Colors.black))
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.planeDeparture,
                    color: Color(0XFF808080),
                  ),
                  SizedBox(
                    width: 120,
                  ),
                  Icon(
                    FontAwesomeIcons.planeArrival,
                    color: Color(0XFF808080),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Divider(
                color: Colors.grey,
                indent: 20,
                endIndent: 20,
                thickness: 0.5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 250, top: 18),
                child: Text('\$ ${widget.price!} ',
                    style: TextStyle(fontSize: 30, color: Color(0XFFe63946))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
