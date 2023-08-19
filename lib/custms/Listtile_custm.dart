import 'package:booking/custms/to_Country.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../commen/theme/light_color_schema.dart';
import '../screens/RegPage.dart';
import 'from_Country.dart';
class ListtilecustmPlan extends StatefulWidget {
  ListtilecustmPlan(
      {required this.text2,
        required this.icons,
        required this.push,
        this.endint});
  String? text2;
  String? push;
  Icon? icons;
  double? endint;
  @override
  State<ListtilecustmPlan> createState() => _ListtilecustmState();
}

String? select1;

class _ListtilecustmState extends State<ListtilecustmPlan> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(top: 7, left: 8),
          child: widget.icons,
        ),
        title: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: select1 == null
                ? Text(
              'Choose Country',
              style: TextStyle(color: Color(0XFF808080), fontSize: 16),
            )
                : Text('$select1')),
        subtitle: Padding(
          padding: const EdgeInsets.only(left: 30, top: 5),
          child: Text(
            '${widget.text2}',
            style: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
        onTap: () async {
          String? result =
          await Navigator.pushNamed<dynamic>(context, '${widget.push}');
          setState(() {
            select1 = result;
          });
        },
      ),
      Divider(
        color: Colors.grey,
        indent: 100,
        endIndent: widget.endint,
        thickness: 0.7,
      )
    ]);
  }
}

class listtilePassanger extends StatefulWidget {
  listtilePassanger(
      {required this.text2,
        required this.icons,
        required this.push,
        this.endint});
  String? text2;
  String? push;
  Icon? icons;
  double? endint;

  @override
  State<listtilePassanger> createState() => _listtilePassangerState();
}

String? select2;

class _listtilePassangerState extends State<listtilePassanger> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(top: 7, left: 8),
          child: widget.icons,
        ),
        title: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: select2 == null
                ? Text(
              'Choose Numbers',
              style: TextStyle(color: Color(0XFF808080), fontSize: 16),
            )
                : Text('$select2')),
        subtitle: Padding(
          padding: const EdgeInsets.only(left: 30, top: 5),
          child: Text(
            '${widget.text2}',
            style: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
        onTap: () async {
          String? result =
          await Navigator.pushNamed<dynamic>(context, '${widget.push}');
          setState(() {
            select2 = result;
          });
        },
      ),
      Divider(
        color: Colors.grey,
        indent: 100,
        endIndent: widget.endint,
        thickness: 0.7,
      )
    ]);
  }
}

class listtileCabin extends StatefulWidget {
  listtileCabin(
      {required this.text2,
        required this.icons,
        required this.push,
        this.endint});
  String? text2;
  String? push;
  Icon? icons;
  double? endint;
  @override
  State<listtileCabin> createState() => _listtileCabinState();
}

String? select3;

class _listtileCabinState extends State<listtileCabin> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(top: 7, left: 8),
          child: widget.icons,
        ),
        title: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: select3 == null
                ? Text(
              'Choose type',
              style: TextStyle(color: Color(0XFF808080), fontSize: 16),
            )
                : Text('$select3')),
        subtitle: Padding(
          padding: const EdgeInsets.only(left: 30, top: 5),
          child: Text(
            '${widget.text2}',
            style: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
        onTap: () async {
          String? result =
          await Navigator.pushNamed<dynamic>(context, '${widget.push}');
          setState(() {
            select3 = result;
          });
        },
      ),
      Divider(
        color: Colors.grey,
        indent: 100,
        endIndent: widget.endint,
        thickness: 0.7,
      )
    ]);
  }
}

class listtilePayment extends StatefulWidget {
  listtilePayment(
      {required this.text2,
        required this.icons,
        required this.push,
        this.endint});
  String? text2;
  String? push;
  Icon? icons;
  double? endint;
  @override
  State<listtilePayment> createState() => _listtilePaymentState();
}

String? select4;

class _listtilePaymentState extends State<listtilePayment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Padding(
            padding: const EdgeInsets.only(top: 7, left: 8),
            child: widget.icons,
          ),
          title: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: select4 == null
                  ? Text(
                'Choose type',
                style: TextStyle(color: Color(0XFF808080), fontSize: 16),
              )
                  : Text('$select4')),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 30, top: 5),
            child: Text(
              '${widget.text2}',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
          ),
          onTap: () async {
            String? result =
            await Navigator.pushNamed<dynamic>(context, '${widget.push}');
            setState(() {
              select4 = result;
            });
          },
        ),
        Divider(
          color: Colors.grey,
          indent: 100,
          endIndent: widget.endint,
          thickness: 0.7,
        ),
      ],
    );
  }
}

class Calender extends StatefulWidget {
  const Calender({Key? key}) : super(key: key);

  @override
  State<Calender> createState() => _CalenderState();
}

DateTime ? picked;
DateTime? selectedDate;
String? date ;

class _CalenderState extends State<Calender> {
  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        onTap: () async {
          final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2024),
              initialDatePickerMode: DatePickerMode.day,
              builder: (Context, child) {
                return Theme(
                    data: Theme.of(context).copyWith(
                        colorScheme:
                        ColorScheme.light(primary: Color(0XFFe63946))),
                    child: child!);
              });
          if (picked != null && picked != selectedDate) {
            setState(() {
              selectedDate = picked;
            });
          }
        },
        leading: Padding(
          padding: const EdgeInsets.only(top: 7, left: 8),
          child: Icon(
            Icons.event,
            color: Color(0XFF808080),
            size: 28,
          ),
        ),
        title: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: selectedDate == null
                ? Text(
              'Select Data',
              style: TextStyle(color: Color(0XFF808080), fontSize: 16),
            )
                : Text("${selectedDate!.toLocal()}".split(' ')[0],
                style: TextStyle(color: Color(0XFF808080), fontSize: 16))),
        subtitle: Padding(
          padding: const EdgeInsets.only(left: 30, top: 5),
          child: Text(
            'Departure Data',
            style: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      Divider(
        color: Colors.grey,
        indent: 100,
        thickness: 0.7,
      )
    ]);
  }
}
String? getDate(){
  //print(pickedDate);
  return date;
}

class calenderR extends StatefulWidget {
  const calenderR({Key? key}) : super(key: key);

  @override
  State<calenderR> createState() => _calenderRState();
}

DateTime? selectedDate2;

class _calenderRState extends State<calenderR> {
  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        onTap: () async {
          final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2024, 2, 12),
              builder: (Context, child) {
                return Theme(
                    data: Theme.of(context).copyWith(
                        colorScheme:
                        ColorScheme.light(primary: Color(0XFFe63946))),
                    child: child!);
              });
          if (picked != null && picked != selectedDate2) {
            setState(() {
              selectedDate2 = picked;
            });
          }
        },
        leading: Padding(
          padding: const EdgeInsets.only(top: 7, left: 8),
          child: Icon(
            Icons.event,
            color: Color(0XFF808080),
            size: 28,
          ),
        ),
        title: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: selectedDate2 == null
                ? Text(
              'Select Data',
              style: TextStyle(color: Color(0XFF808080), fontSize: 16),
            )
                : Text("${selectedDate2!.toLocal()}".split(' ')[0],
                style: TextStyle(color: Color(0XFF808080), fontSize: 16))),
        subtitle: Padding(
          padding: const EdgeInsets.only(left: 30, top: 5),
          child: Text(
            'Return Data',
            style: TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      Divider(
        color: Colors.grey,
        indent: 100,
        thickness: 0.7,
      )
    ]);
  }
}

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
  var m,myinformation,form,to;




  var _isLoading = false;

  void initState() {
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _isLoading = true;
      });
    });
    super.initState();
  }
// @override
//   void initState() {
//   getData();
//     super.initState();
//   }


  @override
  Widget build(BuildContext context) {

    getFlight()  {
      //  var _isLoading = false;
      flight = [];
      fromCity = FromCity();
      toCity = ToCity();
      print(fromCity);
      print(toCity);

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
    }

    getFlight();
    //getFlight();
    return ElevatedButton( // _isLoading?
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(),
            primary: lightColorScheme.surfaceTint, maximumSize: Size(double.infinity, 70)),
        onPressed: () {
          getFlight();
          listFlight();

          if (select1 == null ||
              select2 == null ||
              select3 == null ||
              select4 == null ||
              selectedDate == null ||
              selectedDate2 == null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('This information can not be empty ! '),
              duration: Duration(seconds: 10),
              backgroundColor: Colors.red,
            ));
          }
          else{
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return RegPage(edit: false,);
            })
            );
          };
        },
        child: Center(
            child: Text(
              '${widget.text}',
              style: TextStyle(fontSize: 20),
            )))
    ;
  }
}

List listFlight() {

  return flight;
}
