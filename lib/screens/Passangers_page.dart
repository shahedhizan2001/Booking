import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PassangersPage extends StatefulWidget {
  PassangersPage({Key? key}) : super(key: key);

  @override
  State<PassangersPage> createState() => _PassangersPageState();
}

class _PassangersPageState extends State<PassangersPage> {
  String? dropdownValue1;
  String? dropdownValue2;
  String? dropdownValue3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF1baedf),
        title: Text('Passangers'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              Navigator.pop(context,
                  '$dropdownValue1 adult , $dropdownValue2 child , $dropdownValue3 baby');
            },
          ),
          SizedBox(
            width: 16,
          )
        ],
      ),
      body: Column(children: [
        Column(children: [
          ListTile(
            leading: Padding(
                padding: const EdgeInsets.only(top: 7, left: 8),
                child: Icon(
                  FontAwesomeIcons.male,
                  color: Color(0XFF808080),
                )),
            title: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                'Adult',
                style: TextStyle(color: Color(0XFF808080), fontSize: 16),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 30, top: 5),
              child: Text(
                '> 12 Years',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: DropdownButton(
                elevation: 0,
                value: dropdownValue1,
                items: ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
                    .map((e) => DropdownMenuItem(
                          child: Text(
                            '$e',
                          ),
                          value: e,
                        ))
                    .toList(),
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue1 = value!;
                  });
                },
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
            indent: 100,
            thickness: 0.7,
          )
        ]),
        Column(children: [
          ListTile(
            leading: Padding(
                padding: const EdgeInsets.only(top: 7, left: 8),
                child: Icon(
                  FontAwesomeIcons.child,
                  color: Color(0XFF808080),
                )),
            title: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                'Child',
                style: TextStyle(color: Color(0XFF808080), fontSize: 16),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 30, top: 5),
              child: Text(
                '(2-12 Years)',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: DropdownButton(
                elevation: 0,
                value: dropdownValue2,
                items: ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
                    .map((e) => DropdownMenuItem(
                          child: Text(
                            '$e',
                          ),
                          value: e,
                        ))
                    .toList(),
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue2 = value!;
                  });
                },
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
            indent: 100,
            thickness: 0.7,
          )
        ]),
        Column(children: [
          ListTile(
            leading: Padding(
                padding: const EdgeInsets.only(top: 7, left: 8),
                child: Icon(
                  FontAwesomeIcons.baby,
                  color: Color(0XFF808080),
                )),
            title: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Text(
                'Infant',
                style: TextStyle(color: Color(0XFF808080), fontSize: 16),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 30, top: 5),
              child: Text(
                '(0 - 1 Year)',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: DropdownButton(
                elevation: 0,
                value: dropdownValue3,
                items: ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
                    .map((e) => DropdownMenuItem(
                          child: Text(
                            '$e',
                          ),
                          value: e,
                        ))
                    .toList(),
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue3 = value!;
                  });
                },
              ),
            ),
          ),
        ]),
      ]),
    );
  }
}
