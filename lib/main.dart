import 'package:chat_app/constant/colors.dart';
import 'package:chat_app/constant/dimention.dart';
import 'package:chat_app/constant/routes.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/screens/auth/login_screen.dart';
import 'package:chat_app/screens/auth/register_screen.dart';
import 'package:chat_app/screens/home/home_screen.dart';
import 'package:chat_app/screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void didChangeDependencies() {
    devicewidth = MediaQuery.sizeOf(context).width;
    ddeviceHeight = MediaQuery.sizeOf(context).height;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat app',
      theme: ThemeData(
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontSize: 18),
            bodyMedium: TextStyle(fontSize: 16),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: colorPrimary),
          useMaterial3: true),
      initialRoute: splashScreen,
      routes: {
        splashScreen:(context) => const SplashScreen(),
        loginScreen:(context) => const LoginScreen(),
        registerScreen:(context) => const RegisterScreen(),
        homeScreen:(context) => const HomeScreen(),
      },
    );
  }
}
