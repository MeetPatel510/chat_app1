import 'package:chat_app/constant/colors.dart';
import 'package:chat_app/constant/dimention.dart';
import 'package:chat_app/screens/helper/auth_helper.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/widgets/custom_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final Map<String, dynamic> userData;
  ChatScreen({super.key, required this.userData});

  final TextEditingController messageController = TextEditingController();

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await ChatService().sendMessage(userData['uid'], messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(userData['name'])),
      body: Column(
        children: [
          Expanded(child: _buildMessagesUi()),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    keyboardType: TextInputType.text,
                      label: 'Message', controller: messageController),
                ),
                InkWell(
                    onTap: sendMessage,
                    child: Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: colorPrimary),
                        child: const Icon(
                          Icons.send,
                          color: colorWhite,
                        )))
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildMessagesUi() {
    String senderId = AuthHelper().getCurrentUser()!.uid;
    return StreamBuilder(
        stream: ChatService().getMessage(userData['uid'], senderId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            children: snapshot.data!.docs
                .map((e) => _buildMessageContainer(e))
                .toList(),
          );
        });
  }

  Widget _buildMessageContainer(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderId'] == AuthHelper().getCurrentUser()!.uid;
    CrossAxisAlignment alignment =
        isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    BoxDecoration boxDecoration = isCurrentUser
        ? BoxDecoration(
            color: colorPrimary.withOpacity(0.8),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12)),
          )
        : const BoxDecoration(
            color: colorGray,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12)),
          );
    DateTime time = data['timestamp'].toDate();
    return Column(
      crossAxisAlignment: alignment,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          child: Column(
            crossAxisAlignment: alignment,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: devicewidth / 1.3),
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    decoration: boxDecoration,
                    child: Text(data['message'],
                        style: const TextStyle(
                            color: colorWhite)),
                  ),
                  data['isRead']
                      ? const Icon(Icons.done_all_rounded,
                          size: 12, color: Colors.blue)
                      : const Icon(Icons.check_rounded,
                          size: 12, color: colorIconGray)
                ],
              ),
              Text(
                  '${TimeOfDay.fromDateTime(time).hourOfPeriod}:${TimeOfDay.fromDateTime(time).minute} ${TimeOfDay.fromDateTime(time).period.name}',
                  textAlign: isCurrentUser ? TextAlign.end : TextAlign.start,
                  style: const TextStyle(fontSize: 12))
            ],
          ),
        ),
      ],
    );
  }
}
