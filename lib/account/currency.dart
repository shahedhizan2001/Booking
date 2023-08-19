import 'package:flutter/material.dart';

import '../hotel/app_bar.dart';

class CurrencyListPage extends StatelessWidget {
  final List<String> currencies;

  CurrencyListPage(this.currencies);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Currency List"),

      body: ListView.builder(
        itemCount: currencies.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(currencies[index]),
            onTap: () {
              Navigator.pop(context, currencies[index]);
            },
          );
        },
      ),
    );
  }
}
