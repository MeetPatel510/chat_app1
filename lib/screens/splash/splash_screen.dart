import 'package:chat_app/constant/colors.dart';
import 'package:chat_app/constant/routes.dart';
import 'package:chat_app/screens/helper/auth_helper.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4))
        .then((value) {
          if(AuthHelper().getCurrentUser() != null){
          return Navigator.pushReplacementNamed(context, homeScreen);
          }else{
          return Navigator.pushReplacementNamed(context, loginScreen);
          }
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorSplashBg,
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Image.asset('assets/splash.gif'),
            const Spacer(),
            const Text(
              "Made by Prince Dobariya",
              style: TextStyle(color: colorWhite),
            ),
            const SizedBox(height: 5)
          ],
        ),
      ),
    );
  }
}
