import 'package:flutter/material.dart';

class AddReelsScreen extends StatefulWidget {
  const AddReelsScreen({super.key});

  @override
  State<AddReelsScreen> createState() => _AddReelsScreenState();
}

class _AddReelsScreenState extends State<AddReelsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.amber,
      body: Center(child: Text('Add new Reel')),
    );
  }
}
