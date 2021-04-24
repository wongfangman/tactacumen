import 'package:flutter/material.dart';
import 'loginscreen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      home: LoginScreen(),
      duration: 3000,
      imageSize: 150,
      imageSrc: "assets/images/tactacumen.png",
      text: "TACT ACUMEN",
      textType: TextType.TyperAnimatedText,
      textStyle: TextStyle(
        letterSpacing: 2,
        fontSize: 25.0,
        fontWeight: FontWeight.bold,
      ),
      backgroundColor: Colors.blue[100],
    );
  }
}
