import 'package:booking/hotel/secreens/search_hotel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_bar.dart';
import '../elevated/hotel_secreen_cubit.dart';
import '../elevated/hotel_secreen_state.dart';
import '../textfield.dart';

class SearchDestination1 extends StatefulWidget {
  SearchDestination1({Key? key}) : super(key: key);

  @override
  State<SearchDestination1> createState() => _SearchDestination1State();
}

class _SearchDestination1State extends State<SearchDestination1> {
  List country = [];
  List filteredCountry = [];
  TextEditingController _selectedCountryController = TextEditingController();

  CollectionReference ref = FirebaseFirestore.instance.collection("nation");

  getCountry() async {
    var responsebody = await ref.get();
    responsebody.docs.forEach((element) {
      setState(() {
        country.add(element.data());
      });
    });
  }

  void filterCountries(String query) {
    setState(() {
      filteredCountry = country
          .where((element) =>
              element['country']
                  .toString()
                  .toLowerCase()
                  .startsWith(query.toLowerCase()) ||
              element['city']
                  .toString()
                  .toLowerCase()
                  .startsWith(query.toLowerCase()))
          .toList();
    });
  }

  // CollectionReference refR = FirebaseFirestore.instance.collection("room");
  //
  //
  // getAvgPrice(String ) async  {
  //   List avgPrice = [];
  //   await refR.where("city", isEqualTo: widget.city).get().then((value) {
  //     value.docs.forEach((element) {
  //       setState(() {
  //         avgPrice.add(element.data());
  //       });
  //     });
  //     print(hotel);
  //   });
  //
  // }

  @override
  void initState() {
    getCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelSecreenCubit, HotelSecreenStates>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: appBar(
              title: "Search destination",
              centre: true,
              font: FontWeight.normal,
              automaticallyImplyLeading: false),
          body: country.isNotEmpty
              ? ListView(
                  children: [
                    RSizedBox(
                      height: 15,
                    ),
                    defaultTextFieldSection(
                      controller: _selectedCountryController,
                      prefixIcon: Icons.search,
                      labelText: "Where are you going?",
                      fillColor: Color.fromARGB(20, 118, 232, 232),
                      keyboardType: TextInputType.name,
                      onChanged: (value) => filterCountries(value),
                    ),
                    RSizedBox(
                      height: 30,
                    ),
                    chooseCountries(
                        filteredCountry.isNotEmpty ? filteredCountry : country),
                  ],
                )
              : Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  chooseCountries(List country) {
    return Container(
      height: 500.h,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: country.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey,
          indent: 35.w,
          endIndent: 10.w,
          thickness: 0.7.h,
        ),
        itemBuilder: (context, index) {
          return RPadding(
            padding: const EdgeInsets.all(12.0),
            child: InkWell(
              onTap: () {
                setState(() {
                  _selectedCountryController.text =
                      "${country[index]['country']}, ${country[index]['city']}";
                });
                Future.delayed(const Duration(seconds: 1), () {

                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return SearchHotel(
                      country: '${country[index]['country']}',
                      city: '${country[index]['city']}',
                    );
                  }));
                });
              },
              child: Row(
                children: [
                  Icon(Icons.location_on, color: Colors.black26),
                  RSizedBox(
                    width: 10,
                  ),
                  Text(
                      "${country[index]['country']}, ${country[index]['city']}")
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
