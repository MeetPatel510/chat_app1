import 'package:chat_app/screens/helper/auth_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  FirestoreHelper._();

  static final FirestoreHelper _firestoreHelper = FirestoreHelper._();

  factory FirestoreHelper() => _firestoreHelper;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //add user
  Future<void> addUser({required Map<String, dynamic> user}) async {
    return await _firestore
        .collection('users')
        .doc("${AuthHelper().auth.currentUser?.uid}")
        .set(user);
  }

  // fetch user
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchUser() {
    return _firestore
        .collection('users')
        .where('uid', isNotEqualTo: AuthHelper().auth.currentUser?.uid)
        .snapshots();
  }
}
