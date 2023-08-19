import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ToCountry extends StatefulWidget {
  ToCountry({required this.countryitem, required this.cityitem});

  String? countryitem;
  String? cityitem;

  @override
  State<ToCountry> createState() => _ToCountryState();
}
 String? toCity;
class _ToCountryState extends State<ToCountry> {

  CollectionReference ref = FirebaseFirestore.instance.collection("flight");
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            Navigator.pop(context, widget.cityitem);
            toCity = widget.cityitem;
            print(toCity);

          },
          child: Container(
            width: double.infinity,
            height: 50,
            color: Colors.white38,
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Icon(
                  Icons.location_on,
                  color: Color(0XFF808080),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 50),
                child: Text(
                  widget.countryitem! + ", " + widget.cityitem!,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
            ]),
          ),
        ),
        Divider(
          color: Colors.grey,
          thickness: 0.7,
        )
      ],
    );
  }
}
String? ToCity(){

  return toCity;
}
