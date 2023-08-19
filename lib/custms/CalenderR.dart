
import 'package:flutter/material.dart';

import '../commen/theme/light_color_schema.dart';

class calenderR extends StatefulWidget {
  const calenderR({ Key? key }) : super(key: key);

  @override
  State<calenderR> createState() => _calenderRState();
}
DateTime? selectedDate;
class _calenderRState extends State<calenderR> {


  TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    dateinput.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [ListTile(
          onTap: () async {
            DateTime ? picked = await
            showDatePicker(context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2024),
                builder: (Context, child) {
                  return Theme(
                      data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                              primary: lightColorScheme.surfaceTint)
                      ),
                      child: child!);
                }
            );
            if(picked!= null && picked!= selectedDate){
              setState(() {
                selectedDate = picked;
              });
            }
            print(picked);

          },
          leading:
          Padding(
            padding: const EdgeInsets.only(top: 7, left: 8),
            child: Icon(Icons.event, color: Color(0XFF808080), size: 28,),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 30),
            child:selectedDate == null ? Text(
              'Select Data',
              style: TextStyle(color: Color(0XFF808080), fontSize: 16),
            ): Text("${selectedDate!.toLocal()}".split(' ')[0],style: TextStyle(color: Color(0XFF808080), fontSize: 16),),


          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 30, top: 5),
            child: Text(
              'Return Data',
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
        ),

          Divider(
            color: Colors.grey,
            indent: 100,
            thickness: 0.7,
          )
        ]
    );
  }
}
