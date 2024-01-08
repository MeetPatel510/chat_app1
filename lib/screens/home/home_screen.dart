import 'package:chat_app/constant/routes.dart';
import 'package:chat_app/screens/helper/auth_helper.dart';
import 'package:chat_app/screens/home/chat_home_screen.dart';
import 'package:chat_app/screens/home/profile_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  final List<Widget> _tab = [const ChatHomeScreen(), const ProfileScreen()];

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 40,
          leading: Container(
            margin: const EdgeInsets.only(left: 10),
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/logo.png'))
            ),
        ),
          title: const Text('Chatting'),
          centerTitle: true,
          bottom: TabBar(
            labelStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
              indicatorSize: TabBarIndicatorSize.tab,
              controller: _controller,
              tabs: const [Tab(text: 'Chat'), Tab(text: 'Profile')]),
          actions: [
            IconButton(
                onPressed: () {
                  AuthHelper().logOut().then((value) =>
                      Navigator.pushNamedAndRemoveUntil(
                          context, loginScreen, (route) => false));
                },
                icon: const Icon(Icons.logout))
          ]),
      body: TabBarView(controller: _controller, children: _tab),
      floatingActionButton: FloatingActionButton(onPressed: (){},child: const Icon(Icons.chat_rounded),),
    );
  }
}
