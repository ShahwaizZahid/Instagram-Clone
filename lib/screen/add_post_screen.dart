import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.redAccent,
     body: Center(child: Text('Add new post')),
   );
  }
}
