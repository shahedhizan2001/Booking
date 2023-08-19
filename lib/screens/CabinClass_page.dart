import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../commen/theme/light_color_schema.dart';
import '../custms/container_CP.dart';

class CabinClassPage extends StatelessWidget {
  const CabinClassPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColorScheme.primary,
        title: Text('Select Class'),
      ),
      body: RPadding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          children: [
            CabinPaymentContainer(text: 'Economey'),
            CabinPaymentContainer(text: 'Premium Economey'),
            CabinPaymentContainer(text: 'Business Class'),
            CabinPaymentContainer(text: 'First class')
          ],
        ),
      ),
    );
  }
}