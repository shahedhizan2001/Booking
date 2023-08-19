
import 'package:booking/commen/theme/light_color_schema.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../hotel/secreens/base_page.dart';


class FinishPage extends StatefulWidget {
  const FinishPage({Key? key}) : super(key: key);

  @override
  State<FinishPage> createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPage> {

  @override
  void initState() {
    super.initState();
    // تأخير انتقال الصفحة بعد مرور 6 ثواني
    Future.delayed(Duration(seconds: 8), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BasePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorScheme.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline_sharp,
            color: Colors.white,
            size: 50,
          ),
          SizedBox(
            height: 80,
          ),
          Center(
            child: DefaultTextStyle(
              style: const TextStyle(fontSize: 22.0, color: Colors.white),
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText('Congratulations',
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 40),
                      speed: Duration(milliseconds: 120)),
                  WavyAnimatedText('Your registration has been completed !',
                      textAlign: TextAlign.center,
                      textStyle: TextStyle(fontWeight: FontWeight.w800),
                      speed: Duration(milliseconds: 120)),
                ],
                isRepeatingAnimation: true,
                totalRepeatCount: 100,
                onTap: () {
                  print("Tap Event");
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}