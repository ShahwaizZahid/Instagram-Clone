import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('New Post'),
      backgroundColor: Colors.white,
       actions: [
         Padding(
           padding:  EdgeInsets.symmetric(horizontal:  10.w),
           child: Text('Next',style: TextStyle(fontSize: 15.sp, color: Colors.blue),),
         )
       ],
     ),
   );
  }
}
