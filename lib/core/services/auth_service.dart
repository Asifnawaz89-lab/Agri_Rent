import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/user_model.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Current User Get Karna
  User? get currentUser => _auth.currentUser;

  // 1. Sign Up Function with Role & Firestore Data Saving
  Future<String?> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    required String userRole,
  }) async {
    try {
      // Firebase Auth Mein Account Banayein
      UserCredential res = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // User Model Object Banayein
      UserModel newUser = UserModel(
        uid: res.user!.uid,
        fullName: fullName,
        phoneNumber: phoneNumber,
        email: email,
        userRole: userRole,
      );

      // Firestore Database Mein User Profile Save Karein
      await _db.collection('users').doc(res.user!.uid).set(newUser.toMap());

      return null; // Null means success (no error)
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // 2. Login Function
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
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // 3. User Ka Role Fetch Karna (Farmer / Owner Check Karne Ke Liye)
  Future<String?> getUserRole(String uid) async {
    try {
      DocumentSnapshot doc = await _db.collection('users').doc(uid).get();
      if (doc.exists) {
        return doc.get('userRole') as String?;
      }
    } catch (e) {
      print("Error fetching role: $e");
    }
    return null;
  }

  // 4. Logout Function
  Future<void> signOut() async {
    await _auth.signOut();
  }
}