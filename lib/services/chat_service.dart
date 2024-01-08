import 'package:chat_app/model/message.dart';
import 'package:chat_app/screens/helper/auth_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  ChatService._();
  static final ChatService _chatService = ChatService._();
  factory ChatService() => _chatService;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore
        .collection('users')
        .where('uid', isNotEqualTo: AuthHelper().getCurrentUser()!.uid)
        .snapshots()
        .map((event) {
      return event.docs.map((e) {
        final user = e.data();
        return user;
      }).toList();
    });
  }

  Future<void> sendMessage(String reciverId, String message) async {
    final String currentUserId = AuthHelper().getCurrentUser()!.uid;
    final String currentUserEmail = AuthHelper().getCurrentUser()!.email!;
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
        senderId: currentUserId,
        senderEmail: currentUserEmail,
        reciverID: reciverId,
        message: message,
        timestamp: timestamp);
    List<String> ids = [currentUserId, reciverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    await _firestore
        .collection('chat')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessage(String userId, otherUSerId) {
    List<String> ids = [userId, otherUSerId];
    ids.sort();
    String chatRoomId = ids.join('_');
    _firestore
        .collection('chat')
        .doc(chatRoomId).collection('messages').doc()
        .update({
      'isRead': true,
    });
    return _firestore
        .collection('chat')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots();
  }
}
