import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../commen/theme/light_color_schema.dart';

class region extends StatefulWidget {
  @override
  State<region> createState() => _regionState();
}

class _regionState extends State<region> {
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 3,
          title: Text("Choose City",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal),),
          iconTheme: IconThemeData(
            color: lightColorScheme.surfaceTint,
          ),
        ),
        body: country.isNotEmpty
            ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 0),
              child: ListView.builder(
                  itemCount: country.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        "${country[index]['country']}, ${country[index]['city']}",
                        style: TextStyle(fontSize: 20),
                      ),
                      onTap: () {
                        Navigator.pop(context, country[index]['city']);
                      },
                    );
                  },
                ),
            )
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
