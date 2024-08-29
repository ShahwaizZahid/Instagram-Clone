import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: SizedBox(
          width: 105.w,
          height: 28.h,
          child: Image.asset('assets/images/instagram.jpg'),
        ),
        leading: Image.asset('assets/images/camera.jpg'),
        actions: [
          const Icon(
            Icons.favorite_border_outlined,
            color: Colors.black,
            size: 25,
          ),
          Image.asset('assets/images/send.jpg'),
        ],
        backgroundColor: const Color(0xffFAFAFA),
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
