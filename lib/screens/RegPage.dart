import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../custms/ResCustm.dart';
import '../custms/Search_button.dart';
import '../custms/calenderD.dart';
import '../custms/from_Country.dart';
import '../custms/to_Country.dart';

class RegPage extends StatefulWidget {
  RegPage({Key? key,this.reservationId,required this.edit,this.from,this.to}) : super(key: key);
  String? reservationId;
  bool? edit;
  String? from;
  String? to;


  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {

  addList(){
    List flight = [];
    if(widget.edit == true)
      {
        if (fromCity == widget.from && toCity == widget.to) {
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
        }
        else if (fromCity == "Damascus" && toCity == "Cairo") {
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
        }
        else {
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
      }else{
       flight = listFlight();
    }
  }



  @override
  var _isLoading = false;

  void initState() {
   Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _isLoading = true;
      });
    });
   addList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Reservation'),
          backgroundColor: Color(0XFF1baedf),
        ),
        body: _isLoading? GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, childAspectRatio: 1.7),
          itemCount: flight.length,
          itemBuilder: (context, index) {
            return ResCustm(
                Departure: "${flight[index]['Departure']}",
                arrival: "${flight[index]['arrival']}",
                price: flight[index]['price'],
                date:getDate(),
                from: fromCity,
                to:toCity,
                reservationId: widget.reservationId,
                edit: widget.edit


            )

            ;
          },
        ) :Center(child: CircularProgressIndicator(),)
    );
  }
}
