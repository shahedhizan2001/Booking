import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../commen/theme/light_color_schema.dart';
import '../custms/to_Country.dart';

class ToCountriesPage extends StatefulWidget {
  const ToCountriesPage({Key? key}) : super(key: key);

  @override
  State<ToCountriesPage> createState() => _ToCountriesPageState();
}

class _ToCountriesPageState extends State<ToCountriesPage> {
  List country = [];

  CollectionReference ref = FirebaseFirestore.instance.collection("nation");

  getCountry() async {
    var responsebody = await ref.get();
    responsebody.docs.forEach((element) {
      setState(() {
        country.add(element.data());
      });
    });
  }

  @override
  void initState() {
    getCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
        AppBar(
          backgroundColor: lightColorScheme.primary,
          title: Text('Choose City'),
        ),
        body: country.isNotEmpty
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, childAspectRatio: 5),
                itemCount: country.length,
                itemBuilder: (context, Index) {
                  return ToCountry(
                      countryitem: "${country[Index]['country']}",
                      cityitem: "${country[Index]['city']}");
                })
            : Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                  heightFactor: double.infinity,
                  widthFactor: double.infinity,
                ),
              ));
  }
}
