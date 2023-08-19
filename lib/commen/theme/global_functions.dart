import 'package:firebase_auth/firebase_auth.dart';

class GlobalFunctions {
  Future<bool> isAuth() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }
}
