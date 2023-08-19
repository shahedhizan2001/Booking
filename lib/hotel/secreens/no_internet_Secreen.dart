import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../commen/theme/light_color_schema.dart';

class NoInternetSecreen extends StatelessWidget {
  final VoidCallback onRetry;

  NoInternetSecreen({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Center(
          child: Column(
            children: [
              RSizedBox(
                height: 50,
              ),
              SvgPicture.asset(
                "assets/icons/sad-circle-svgrepo-com (1).svg",
                height: 200.h,
                color: lightColorScheme.primary,
              ),
              RSizedBox(
                height: 18,
              ),
              Text(
                "No Internet Connected",
                style: TextStyle(fontSize: 23),
              ),
              ElevatedButton(
                onPressed: onRetry,
                child: Text('Try again'),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
//
// // تستخدم هذه الوظيفة للتحقق من توافر الاتصال بالإنترنت
// Future<bool> checkInternetConnectivity() async {
//   var connectivityResult = await (Connectivity().checkConnectivity());
//   return connectivityResult != ConnectivityResult.none;
// }