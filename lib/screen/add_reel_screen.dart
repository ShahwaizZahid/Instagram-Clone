import 'package:flutter/material.dart';

class AddReelsScreen extends StatefulWidget {
  const AddReelsScreen({super.key});

  @override
  State<AddReelsScreen> createState() => _AddReelsScreenState();
}

class _AddReelsScreenState extends State<AddReelsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'New Reels',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
