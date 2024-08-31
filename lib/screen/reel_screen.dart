import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReelScreen extends StatefulWidget {
  const ReelScreen({super.key});

  @override
  State<ReelScreen> createState() => _ReelScreenState();
}

class _ReelScreenState extends State<ReelScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("reels"),
      ),
    );
  }
}




// SizedBox(height: 20.h),
// SizedBox(
// height: 60,
// width: 280.w,
// child: TextField(
// controller: caption,
// maxLines: 10,
// decoration: const InputDecoration(
// hintText: 'Write a caption ...',
// border: InputBorder.none,
// ),
// ),
// ),
// Divider(),
// SizedBox(height: 20.h),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// GestureDetector(
// onTap: () {
// // Save draft functionality
// },
// child: Container(
// alignment: Alignment.center,
// height: 45.h,
// width: 150.w,
// decoration: BoxDecoration(
// color: Colors.white,
// border: Border.all(
// color: Colors.black,
// ),
// borderRadius: BorderRadius.circular(10.r),
// ),
// child: Text(
// 'Save draft',
// style: TextStyle(fontSize: 16.sp),
// ),
// ),
// ),
// GestureDetector(
// onTap: () async {
// // Share functionality
// },
// child: Container(
// alignment: Alignment.center,
// height: 45.h,
// width: 150.w,
// decoration: BoxDecoration(
// color: Colors.blue,
// borderRadius: BorderRadius.circular(10.r),
// ),
// child: Text(
// 'Share',
// style: TextStyle(
// fontSize: 16.sp,
// color: Colors.white,
// fontWeight: FontWeight.bold,
// ),
// ),
// ),
// ),
// ],
// )