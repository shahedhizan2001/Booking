
import 'package:flutter/material.dart';
import '../custms/container_CP.dart';

class TypePaymentPage extends StatelessWidget {
  const TypePaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF004E98),
        title: Text(
          'Preferred Payment Types',
        ),
      ),
      body: Column(
        children: [
          CabinPaymentContainer(text: 'PayPal'),
          CabinPaymentContainer(text: 'American Express'),
          CabinPaymentContainer(text: 'Diners Club'),
          CabinPaymentContainer(text: 'JCB'),
          CabinPaymentContainer(text: 'MasterCard Credit'),
          CabinPaymentContainer(text: 'Visa Credit'),
          CabinPaymentContainer(text: 'Bank Transfer'),
        ],
      ),
    );
  }
}
