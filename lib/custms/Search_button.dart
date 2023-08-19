import 'package:booking/custms/to_Country.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../commen/theme/light_color_schema.dart';
import '../screens/RegPage.dart';
import 'calenderD.dart';
import 'from_Country.dart';

List flight = [];

class SearchButton extends StatefulWidget {
  SearchButton({required this.text});

  String? text;

  //var flight = [];

  @override
  State<SearchButton> createState() => _SearchButtonState();
}

CollectionReference refflight = FirebaseFirestore.instance.collection("flight");

class _SearchButtonState extends State<SearchButton> {
  String? fromCity;
  String? toCity;
  var m, myinformation, form, to;

  // var _isLoading = false;
  //
  // void initState() {
  //   Future.delayed(Duration(seconds: 5), () {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //   });
  //   super.initState();
  // }

// @override
//   void initState() {
//   getData();
//     super.initState();
//   }

  @override
  Widget build(BuildContext context) {
    getFlight() {
      //  var _isLoading = false;
      flight = [];
      fromCity = FromCity();
      toCity = ToCity();

      if (fromCity == "Erbil" && toCity == "paris") {
        refflight
            .where("from", isEqualTo: fromCity)
            .where("to", isEqualTo: toCity)
            .where("Date", isEqualTo: '${getDate()}')
            .get()
            .then((value) {
          value.docs.forEach((element) {
            flight.add(element.data());
          });
          print(flight);
        });
      } else if (fromCity == "Damascus" && toCity == "Cairo") {
        refflight
            .where("from", isEqualTo: '${fromCity}')
            .where("to", isEqualTo: '${toCity}')
            .where("Date", isEqualTo: '${getDate()}')
            .get()
            .then((value) {
          value.docs.forEach((element) {
            flight.add(element.data());
          });
          print(flight);
        });
      } else {
        refflight
            .where("from", isEqualTo: '${fromCity}')
            .where("to", isEqualTo: '${toCity}')
            .get()
            .then((value) {
          value.docs.forEach((element) {
            flight.add(element.data());
          });
          print(flight);
        });
      }
    }

    getFlight();
    //getFlight();
    return ElevatedButton(
        // _isLoading?
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(),
            primary: lightColorScheme.surfaceTint,
            maximumSize: Size(double.infinity, 70)),
        onPressed: () {
          getFlight();
          listFlight();

          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return RegPage(
              edit: false,
            );
          }));
        },
        child: Center(
            child: Text(
          '${widget.text}',
          style: TextStyle(fontSize: 20),
        )));
  }
}

List listFlight() {
  return flight;
}
