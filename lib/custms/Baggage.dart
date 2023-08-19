// import 'package:flutter/material.dart';
//
// class baggageCustom extends StatelessWidget {
//    baggageCustom({ required this.text1,required this.text2,required this.text3}) ;
//   String? text1;
//   String? text2;
//   String? text3;
//
//   @override
//   Widget build(BuildContext context) {
//     return  Padding(
//         padding: const EdgeInsets.only(left: 16,right: 16,top: 10),
//         child: Container(
//           width: double.infinity,
//           height:200,
//           child: Card(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top:15),
//                   child: Text('$text1',style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w700),),
//                 ),
//                 SizedBox(height: 12,),
//                 Text('$text2',style: TextStyle(fontSize: 16,color: Colors.black)),
//                 Text('$text3',style: TextStyle(fontSize: 16,color: Colors.black)),
//                 SizedBox(height: 20,),
//                 Row(
//                   children: [
//
//                     SizedBox(width: 70,),
//                     Container(
//                       margin: EdgeInsets.only(top: 35,left: 140),
//                       height: 30,
//                       width: 100,
//                       decoration:BoxDecoration(borderRadius: BorderRadius.circular(16),color: Colors.blue.withOpacity(0.3)),
//                       child: Center(child: Text('Included',style: TextStyle(fontSize: 16,color: Colors.blue),)),
//                     )
//                   ],
//                 )
//               ],
//             )
//           ),
//         ),
//       );
//   }
// }