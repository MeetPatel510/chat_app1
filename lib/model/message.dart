import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String reciverID;
  final String message;
  final bool isRead;
  final Timestamp timestamp;
  Message({
    required this.senderId,
    required this.senderEmail,
    required this.reciverID,
    required this.message,
    this.isRead = false,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() => {
        'senderId': senderId,
        'senderEmail':senderEmail,
        'reciverID':reciverID,
        'message':message,
        'isRead':isRead,
        'timestamp':timestamp,
      };
}
