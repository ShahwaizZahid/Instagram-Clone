import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("gh"),
        leading: IconButton(onPressed: (){signOut();}, icon: Icon(Icons.logout)),
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      print("User successfully logged out.");
    } catch (e) {
      print("Error signing out: $e");
    }
  }

}
