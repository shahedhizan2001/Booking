//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mynotewithdatabase/hotel/search_hotel.dart';
// import 'package:mynotewithdatabase/hotel/textfield.dart';
//
// import '../commen/theme/light_color_schema.dart';
// import 'elevatedbottom.dart';
//
//
//  class SearchDestination extends StatefulWidget {
//    SearchDestination({Key? key}) : super(key: key);
//
//   @override
//   State<SearchDestination> createState() => _SearchDestinationState();
// }
//
// class _SearchDestinationState extends State<SearchDestination> {
//   List country = [];
//   List finalCountry = [];
//   List city = [];
//   var myinformation,x;
//   String? inCity;
//   String? inCountry;
//
//   CollectionReference ref = FirebaseFirestore.instance.collection("nation");
//   getCountry() async {
//     var responsebody = await ref.get();
//     responsebody.docs.forEach((element) {
//       x=element.data();
//       setState(() {
//         country.add(x['country']);
//       });
//     });
//     finalCountry = country.toSet().toList();
//   }
//   getCity () async{
//     city = [];
//     await ref
//         .where("country", isEqualTo: "${inCountry}")
//         .get()
//         .then((value) {
//       value.docs.forEach((element) {
//         x=element.data();
//         setState(() {
//           city.add(x['city']);
//         });
//       });
//
//     });
//   }
//
//   @override
//   void initState() {
//     getCountry();
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text(
//           "Search destination",
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),
//         ),
//         backgroundColor: Colors.white,
//         iconTheme: IconThemeData(color:  lightColorScheme.primary),
//         elevation: 0,
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             SizedBox(height: 15,),
//
//             DropdownSearch(
//               mode: Mode.MENU,
//               showSelectedItems: false,
//               items: finalCountry,
//               dropdownSearchDecoration: InputDecoration(
//                 labelText: "Choose the Country you want to go to",
//                 //    hintText: "country in menu mode"
//               ),
//               // popupItemDisabled:
//               onChanged: (value) {
//                 print(value);
//                 inCountry = value;
//                 getCity();
//               } ,
//               showSearchBox: true,
//               searchFieldProps: TextFieldProps(cursorColor: Colors.blue),
//               maxHeight: 500,
//             ),
//             SizedBox(height: 10,),
//             DropdownSearch(
//               mode: Mode.MENU,
//               showSelectedItems: false,
//               items: city,
//               dropdownSearchDecoration: InputDecoration(
//                 labelText: "Choose the City you want to go to",
//                 //    hintText: "country in menu mode"
//               ),
//               // popupItemDisabled:
//               onChanged: (value) {
//                 print(value);
//                 inCity = value;
//               } ,
//               showSearchBox: true,
//               searchFieldProps: TextFieldProps(cursorColor: Colors.blue),
//               maxHeight: 500,
//             ),
//             SizedBox(height: 20,),
//             defaultElevatedBottom(
//               icons: Icons.search,
//               title: "Search hotels",
//               function: () {
//                 Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) {
//                         return SearchHotel(city: inCity , country: inCountry);
//                       },));
//               },
//               padding: EdgeInsets.all(12.0),
//               colors: Colors.white,
//               backgroundColor:lightColorScheme.primary,
//               size: Size.fromHeight(50),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(30)),
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
//   // bool isItemDisabled(String s){
//   //   if (s.startsWith('I'))
//   //     return true;
//   //   else
//   //     return false;
//   //
//   // }
//   // void itemSelectionChanded(String? s){
//   //   print(s);
//   // }
//
// }
//
//
//
