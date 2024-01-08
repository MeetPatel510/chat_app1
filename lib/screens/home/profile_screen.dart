import 'package:chat_app/constant/dimention.dart';
import 'package:chat_app/screens/helper/auth_helper.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String username = AuthHelper().getCurrentUser()!.email!.split("@")[0];
    String email = AuthHelper().getCurrentUser()!.email!;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.topCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: devicewidth,
              child: Container(
                height: 100,
                width: 100,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Image.asset(
                  'assets/person/1.png',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text("Username  :  $username"),
            ),
            Text("Email          :  $email"),
          ],
        ),
      ),
    );
  }
}
