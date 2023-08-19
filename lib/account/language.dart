import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Language'),
      ),
      body: Column(
        children: <Widget>[
          RadioListTile(
            title: Text('English'),
            value: 'English',
            groupValue: _selectedLanguage,
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value!;
              });
            },
          ),
          RadioListTile(
            title: Text('العربية'),
            value: 'العربية',
            groupValue: _selectedLanguage,
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value!;
              });
            },
          ),
          ElevatedButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.pop(context, _selectedLanguage);
            },
          )
        ],
      ),
    );
  }
}
