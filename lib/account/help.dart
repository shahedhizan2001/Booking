import "package:flutter/material.dart";

import "../hotel/app_bar.dart";

class help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Help Center"),
      // AppBar(
      //   title: Text('Help Center'),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Welcome to the Help Center!',
            style: TextStyle(fontSize: 24.0),
          ),
          SizedBox(height: 20.0),
          Text(
            'Here you can find answers to common questions and get support.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              // Add code to open support page or FAQ page
            },
            child: Text('Support',),
            
          ),
        ],
      ),
    );
  }
}
