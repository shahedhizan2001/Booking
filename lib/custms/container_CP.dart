import 'dart:typed_data';

import 'package:flutter/material.dart';

class CabinPaymentContainer extends StatelessWidget {
   CabinPaymentContainer({ required this.text}) ;
  String? text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      GestureDetector(
        onTap: (){
         Navigator.pop(context,text);
        },
        child: Container(
          width: double.infinity,
          height: 50,
          color: Colors.white38,
          
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15,left: 50),
                      child: Text(
                        '$text',
                        style: TextStyle(color:  Colors.black, fontSize: 20),
                      ),
                    ),
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