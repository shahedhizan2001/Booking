import 'package:booking/hotel/elevated/hotel_secreen_cubit.dart';
import 'package:booking/hotel/elevated/hotel_secreen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PassangersPage extends StatefulWidget {
  PassangersPage({Key? key}) : super(key: key);

  @override
  State<PassangersPage> createState() => _PassangersPageState();
}

class _PassangersPageState extends State<PassangersPage> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelSecreenCubit,HotelSecreenStates>(
      builder: (context, state) {
        HotelSecreenCubit cubit=HotelSecreenCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0XFF1baedf),
            title: Text('Passangers'),
            actions: [
              IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  if(cubit.dropdownValue1==null && cubit.dropdownValue2==null && cubit.dropdownValue3==null)
                  {

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Please enter numbers'),
                      duration: Duration(seconds: 10),
                      backgroundColor: Colors.red,
                    )
                    );
                  }

                  else if(cubit.dropdownValue1!=null && cubit.dropdownValue2!=null && cubit.dropdownValue3!=null){
                    Navigator.pop(context,'${cubit.dropdownValue1} adult , ${cubit.dropdownValue2} child , ${cubit.dropdownValue3} baby');
                  }
                  else if(cubit.dropdownValue1!=null && cubit.dropdownValue2!=null){
                    Navigator.pop(context,'${cubit.dropdownValue1} adult , ${cubit.dropdownValue2} child ');
                  }
                  else if(cubit.dropdownValue1!=null && cubit.dropdownValue3!=null){
                    Navigator.pop(context,'${cubit.dropdownValue1} adult , ${cubit.dropdownValue3} baby ');
                  }
                  else if(cubit.dropdownValue2!=null && cubit.dropdownValue3!=null){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Should be an adult ! '),
                      duration: Duration(seconds: 10),
                      backgroundColor: Colors.red,
                    )
                    );
                  }
                  else if(cubit.dropdownValue1!=null){
                    Navigator.pop(context,'${cubit.dropdownValue1} adult ');
                  }
                  else if(cubit.dropdownValue2!=null){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Should be an adult ! '),
                      duration: Duration(seconds: 10),
                      backgroundColor: Colors.red,
                    )
                    );
                  }
                  else if(cubit.dropdownValue3!=null){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Should be an adult ! '),
                      duration: Duration(seconds: 10),
                      backgroundColor: Colors.red,
                    )
                    );
                  }
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
                    value: cubit.dropdownValue1,
                    items: ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
                        .map((e) => DropdownMenuItem(
                      child: Text(
                        '$e',
                      ),
                      value: e,
                    ))
                        .toList(),
                    onChanged: (value) {
                      cubit.updateDropdownValue1(value!);
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
                    value: cubit.dropdownValue2,
                    items: [ "1", "2", "3", "4", "5", "6", "7", "8", "9"]
                        .map((e) => DropdownMenuItem(
                      child: Text(
                        '$e',
                      ),
                      value: e,
                    ))
                        .toList(),
                    onChanged: (value) {
                      cubit.updateDropdownValue2(value!);
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
                    value: cubit.dropdownValue3,
                    items: [ "1", "2", "3", "4", "5", "6", "7", "8", "9"]
                        .map((e) => DropdownMenuItem(
                      child: Text(
                        '$e',
                      ),
                      value: e,
                    ))
                        .toList(),
                    onChanged: (value) {
                      cubit.updateDropdownValue3(value!);
                    },
                  ),
                ),
              ),
            ]),
          ]),
        );
      },
    );
  }
}
