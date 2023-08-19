import 'package:flutter/material.dart';

import '../commen/theme/light_color_schema.dart';
import '../custms/Baggage.dart';
import 'information_passport.dart';

class BagsPage extends StatefulWidget {
   BagsPage({ Key? key ,this.price}) : super(key: key);

  int? price;

  @override
  State<BagsPage> createState() => _BagsPageState();
}

class _BagsPageState extends State<BagsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: (){
              addReservationFlight();
             Navigator.pushNamed(context, 'FinishPage');
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 20,right: 16),
              child: Text('Submit',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
            ),
          )
        ],
        backgroundColor:  Color(0XFF1baedf),
        title: Text(
          'Select baggage',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          baggageCustom(
            text1: '  Personal item',
            text2: '    A small bag that must fit under the seat in',
            text3: '    front of you.',
          ),
          baggageCustom(text1: '  Hand baggage', text2: '    Backpack or handbag that goes in the', text3: '    overhead compartment.    1 x 7 kg'),
          baggageCustom(text1: '  Checked baggage', text2: '    Suitcase or other bag that you want to check', text3: '    in.    1 x 24 kg')
        ]
        ),
      ),
      bottomNavigationBar: Container(
        color:  lightColorScheme.primary,
        width:double.infinity ,
        height: 50,
        child: Center(child: Text('Total :${widget.price} ' ,style: TextStyle(
      fontSize: 20,color: Colors.white,
      fontWeight: FontWeight.w700
     ),
     )
     ),
      ),
    );
  }
}
