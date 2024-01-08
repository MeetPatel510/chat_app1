import 'package:chat_app/screens/auth/auth_model.dart';
import 'package:chat_app/screens/helper/firestore_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthHelper {
  AuthHelper._();
  static final AuthHelper _authHelper = AuthHelper._();
  factory AuthHelper() => _authHelper;

  final FirebaseAuth auth = FirebaseAuth.instance;

  // get current user
  User? getCurrentUser(){
    return auth.currentUser;
  }

  Future<Map<String, dynamic>> logIn({required LoginModel data}) async {
    Map<String, dynamic> res = {};
    try {
      UserCredential? userCredential;
      if (data.emailPhone!.contains('@')) {
        userCredential = await auth.signInWithEmailAndPassword(
            email: data.emailPhone!, password: data.password!);
           
      }
      res['user'] = userCredential?.user;
    } on FirebaseAuthException catch (e) {
      res['error'] = e.message;
    }
    return res;
  }

  Future<Map<String, dynamic>> register({required RegisterModel data}) async {
    Map<String, dynamic> res = {};
    try {
      UserCredential? userCredential;
      
        userCredential = await auth.createUserWithEmailAndPassword(
            email: data.emailPhone!, password: data.password!);
        List image = [1,2,3,4,5];
        image.shuffle();
        FirestoreHelper().addUser(user: {
        "name":(userCredential.user?.displayName == null)
            ? userCredential.user?.email?.split("@")[0]
            : userCredential.user?.displayName,
            "email":userCredential.user?.email,
            "uid":userCredential.user?.uid,
            "image":image[0]
      });

      res['user'] = userCredential.user;

    } on FirebaseAuthException catch (e) {
      res['error'] = e.message;
    }
    return res;
  }

  Future<void> logOut() async {
    await auth.signOut();
  }
}
