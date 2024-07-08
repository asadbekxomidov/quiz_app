import 'package:firebase_auth/firebase_auth.dart';

class FireBaseAuthService {
  static Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'An unknown error occurred';
    } catch (e) {
      throw 'An unknown error occurred';
    }
  }

  static Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'An unknown error occurred';
    } catch (e) {
      throw 'An unknown error occurred';
    }
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
