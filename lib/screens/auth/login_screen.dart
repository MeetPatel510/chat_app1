import 'package:chat_app/constant/colors.dart';
import 'package:chat_app/constant/routes.dart';
import 'package:chat_app/screens/auth/auth_model.dart';
import 'package:chat_app/screens/helper/auth_helper.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:chat_app/widgets/custom_textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Spacer(),
          Image.asset('assets/logo.png', width: 100, height: 100),
          const Spacer(),
          CustomTextField(
            keyboardType: TextInputType.emailAddress,
            label: 'Email',
            controller: emailController,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            label: 'Password',
            controller: passwordController,
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              AuthHelper()
                  .logIn(
                      data: LoginModel(
                          emailController.text, passwordController.text))
                  .then((value) {
                if (value['user'] != null) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, homeScreen, (route) => false);
                } else {
                  snackbar(context, 'Try again later');
                }
              });
            },
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  border: Border.all(color: colorGray),
                  color: colorPrimary,
                  borderRadius: BorderRadius.circular(5)),
              child: const Text('Login',style: TextStyle(color: colorWhite)),
            ),
          ),
          const SizedBox(height: 20),
          Text.rich(
            TextSpan(children: [
              const TextSpan(text: 'You have Not Account? '),
              TextSpan(
                  text: 'Register',
                  recognizer: TapGestureRecognizer()
                    ..onTap =
                        () => Navigator.pushNamed(context, registerScreen))
            ]),
          ),
          const Spacer()
        ]),
      ),
    );
  }
}
