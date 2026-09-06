import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user_model.dart'; // Relative path import

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Sign Up
  Future<String?> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    required String userRole,
  }) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        UserModel userModel = UserModel(
          uid: credential.user!.uid,
          fullName: fullName,
          email: email,
          phoneNumber: phoneNumber,
          role: userRole,
        );

        await _db
            .collection('users')
            .doc(credential.user!.uid)
            .set(userModel.toMap());
      }
      return null; // Success
    } catch (e) {
      return e.toString();
    }
  }

  // Login
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null; // Success
    } catch (e) {
      return e.toString();
    }
  }

  // Get User Role
  Future<String?> getUserRole(String uid) async {
    try {
      DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
      if (doc.exists && doc.data() != null) {
        return (doc.data() as Map<String, dynamic>)['role'];
      }
    } catch (_) {}
    return 'farmer';
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}