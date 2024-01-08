import 'package:chat_app/screens/chat/chat_screen.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:flutter/material.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  final ChatService _chatService = ChatService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: _chatService.getUserStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              Center(child: Text("${snapshot.error}"));
            }
            return ListView(
              children: snapshot.data!
                  .map<Widget>(
                    (e) => _buildUserListContainer(e),
                  )
                  .toList(),
            );
          }),
    );
  }

  _buildUserListContainer(Map<String, dynamic> userData) {
    return ListTile(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(userData: userData),
          )),
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/person/${userData['image']}.png'),
      ),
      title: Text(userData['name']),
    );
  }
}
