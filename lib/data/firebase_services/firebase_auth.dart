import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:isntragram_clone/data/firebase_services/storage.dart';

import '../../util/exception.dart';
import 'firestore.dart';

class Authentication {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> Login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
    } on FirebaseException catch (e) {
      throw exceptions(e.message.toString());
    }
  }

  Future<void> Signup({
    required String email,
    required String password,
    required String passwordConfirme,
    required String username,
    required String bio,
    required File? profile,
  }) async {
    String URL = '';
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Upload profile image to storage
      if (profile != null && profile.path.isNotEmpty) {
        URL = await StorageMethod().uploadImageToStorage('Profile', profile);
      }

      // Create user information in Firestore
      await Firebase_Firestor().CreateUser(
        email: email,
        username: username,
        bio: bio,
        profile: URL.isEmpty
            ? 'https://firebasestorage.googleapis.com/v0/b/instagram-8a227.appspot.com/o/person.png?alt=media&token=c6fcbe9d-f502-4aa1-8b4b-ec37339e78ab'
            : URL,
      );
    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication errors
      throw exceptions(e.message ?? 'An authentication error occurred.');
    } on FirebaseException catch (e) {
      throw exceptions('Firebase error: ${e.message}');
    } catch (e) {
      throw exceptions('An unexpected error occurred: $e');
    }
  }
}
