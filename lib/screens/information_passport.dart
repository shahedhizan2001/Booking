
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../commen/theme/light_color_schema.dart';
import '../hotel/secreens/base_page.dart';
import 'Finish_page.dart';
class InfoPassportPage extends StatefulWidget {
  InfoPassportPage(
      {Key? key, this.Departure, this.arrival, this.price, this.from, this.to,this.reservationId,required this.edit})
      : super(key: key);
  String? Departure;
  String? arrival;
  int? price;
  String? from;
  String? to;
  String? reservationId;
  bool? edit;


  @override
  State<InfoPassportPage> createState() => _InfoPassportPageState();
}

String? Departure;

String? arrival;
int? price;
String? from;
String? to;
String? reservationId;
bool? edit;


class _InfoPassportPageState extends State<InfoPassportPage> {
  DateTime? SelectedDate;
  DateTime? SelectedDate1;
  bool _isMale = false;
  bool _isFemale = false;
  final _formkey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();

  DateTime selectedDate1 = DateTime.now();
  TextEditingController _date = new TextEditingController();

  TextEditingController _textEditingController = TextEditingController();

  TextEditingController _date1 = new TextEditingController();

  TextEditingController _textEditingController1 = TextEditingController();
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1930),
        lastDate: DateTime.now(),
        builder: (Context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(primary:lightColorScheme.surfaceTint)),
              child: child!);

        });
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _date.value = TextEditingValue(text: "${selectedDate.toLocal()}".split(' ')[0]);
      });
    }
  }


  Future<Null> _selectDate1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2032),
        builder: (Context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(primary: lightColorScheme.surfaceTint)),
              child: child!);

        });
    if (picked != null && picked != SelectedDate1) {
      setState(() {
        selectedDate1 = picked;
        _date1.value = TextEditingValue(text:  "${selectedDate1.toLocal()}".split(' ')[0]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Passport Information'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0XFF1baedf),
      ),
      body: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18, left: 18),
                child: Text(
                  'Gender',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Row(
                  children: [
                    SizedBox(
                      width: 16,
                    ),
                    Checkbox(
                      shape: CircleBorder(),
                      activeColor: Color(0XFFe63946),
                      checkColor: Color(0XFFe63946),
                      value: _isMale,
                      onChanged: (bool? value) {
                        setState(() {
                          _isMale = value!;
                          if (_isMale) {
                            _isFemale = false;
                          }
                        });
                      },
                    ),
                    Text('Male',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 16)),
                  ],
                ),
                SizedBox(
                  width: 60,
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: Color(0XFFe63946),
                      checkColor: Color(0XFFe63946),
                      shape: CircleBorder(),
                      value: _isFemale,
                      onChanged: (bool? value) {
                        setState(() {
                          _isFemale = value!;
                          if (_isFemale) {
                            _isMale = false;
                          }
                        });
                      },
                    ),
                    Text('Female',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 16)),
                  ],
                ),
              ]),
              Padding(
                padding: const EdgeInsets.only(top: 18, left: 18),
                child: Text(
                  'Given + middle name',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: TextFormField(
                  onSaved: (String? value) {

                  },
                  validator: (String? value) {
                    final RegExp dateRegex = RegExp(r'^[a-zA-Z]+$');
                    return (value != null && !dateRegex.hasMatch(value.toString())) ? 'It must not be empty , Do not use the numbrs or symbol' : null;
                  },
                  decoration: InputDecoration(
                    helperStyle: TextStyle(color: Color(0XFF808080)),
                    hintText: 'As written in the passport',
                    hintStyle: TextStyle(color: Color(0XFF808080)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0XFF1baedf))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0XFF1baedf))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18, left: 18),
                child: Text(
                  'Surname / Family name',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: TextFormField(
                  onSaved: (String? value) {

                  },
                  validator: (String? value) {
                    final RegExp dateRegex = RegExp(r'^[a-zA-Z]+$');
                    return (value != null && !dateRegex.hasMatch(value.toString())) ? 'It must not be empty , Do not use the numbrs or symbol' : null;
                  },
                  decoration: InputDecoration(
                    helperStyle: TextStyle(color: Color(0XFF808080)),
                    hintText: 'As written in the passport',
                    hintStyle: TextStyle(color: Color(0XFF808080)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0XFF1baedf))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Color(0XFF1baedf))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18, left: 18),
                child: Text(
                  'Your Birthday',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child:GestureDetector(
                    onTap: (){
                      //_textEditingController.text = DateFormat('dd/mm/yyyy').format(selectedDate);
                      _selectDate(context);
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        onSaved: (String? value) {},
                        validator: (String? value) {
                          if(value!.isEmpty){
                            return('Your Birthday can not be empty');
                          }
                        },
                        controller: _date,
                        decoration: InputDecoration(
                          helperStyle: TextStyle(color: Color(0XFF808080)),
                          hintText: 'Enter the date',
                          hintStyle: TextStyle(color: Color(0XFF808080)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0XFF1baedf))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0XFF1baedf))),
                        ),
                      ),
                    ),
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18, left: 18),
                child: Text(
                  'The expiry date of your passport',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: GestureDetector(
                    onTap: (){
                      //_textEditingController1.text = DateFormat('yyyy/MM/dd').format(selectedDate1);
                      _selectDate1(context);
                    },
                    child: AbsorbPointer(
                      child: TextFormField(
                        onSaved: (String? value) {},
                        validator: (String? value) {
                          if(value!.isEmpty){
                            return('The expiry date can not be empty');
                          }
                        },
                        controller: _date1,
                        decoration: InputDecoration(
                          helperStyle: TextStyle(color: Color(0XFF808080)),
                          hintText: 'Enter the date',
                          hintStyle: TextStyle(color: Color(0XFF808080)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0XFF1baedf))),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Color(0XFF1baedf))),
                        ),
                      ),
                    ),
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 18),
                child: Text(
                    'Enter The expiry date like this: Day-Month-Year (DD-MM-YYYY)',
                    style: TextStyle(color: Colors.black.withOpacity(0.4))),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
          style: ElevatedButton.styleFrom(
              maximumSize: Size(double.infinity, 70),
              shape: RoundedRectangleBorder()
          ),
          onPressed: () {
            Departure = widget.Departure;
            arrival = widget.arrival;
            price = widget.price;
            from = widget.from;
            to = widget.to;
            reservationId = widget.reservationId;
            edit = widget.edit;


            if (_formkey.currentState!.validate() && (_isFemale || _isMale)) {
              addReservationFlight();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FinishPage()));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  'Please make sure your data is correct ! ',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                backgroundColor: Colors.red.shade600,
                duration: Duration(seconds: 6),
              ));
            }
          },
          child: Center(
              child: Text(
                'Continue',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ))),
    );
  }
}

addReservationFlight() {
  CollectionReference reservationRef =
  FirebaseFirestore.instance.collection("reservationFlight");
  print("add reservationFlight");

  if (edit == false) {
    reservationRef.add({
      'Departure': Departure,
      'arrival': arrival,
      'price': price,
      'from': from,
      'to': to,
      'userId': getUser()
    }).then((value) {
      reservationRef.doc(value.id).update({
        'reservationId': value.id,
      });
    });
    print("final");
  } else if (edit == true) {
    reservationRef.doc(reservationId).update({
      'Departure': Departure,
      'arrival': arrival,
      'price': price,
      'from': from,
      'to': to,
      'userId': getUser(),
      'reservationId': reservationId
    });
  } else {
    print("error");
  }
}
