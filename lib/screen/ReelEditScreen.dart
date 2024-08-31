import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

import '../data/firebase_services/firestore.dart';
import '../data/firebase_services/storage.dart';

class ReelsEditeScreen extends StatefulWidget {
  final File videoFile;
  ReelsEditeScreen(this.videoFile, {super.key});

  @override
  State<ReelsEditeScreen> createState() => _ReelsEditeScreenState();
}

class _ReelsEditeScreenState extends State<ReelsEditeScreen> {
  final caption = TextEditingController();
  late VlcPlayerController _vlcPlayerController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _vlcPlayerController = VlcPlayerController.file(
      widget.videoFile,
      autoPlay: true,
      options: VlcPlayerOptions(),
    );
  }

  @override
  void dispose() {
    _vlcPlayerController.dispose();
    caption.dispose();
    super.dispose();
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: false,
        title: const Text(
          'New Reels',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
          child: CircularProgressIndicator(
            color: Colors.black,
          ),
        )
            : Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Container(
                  width: 270.w,
                  height: 420.h,
                  child: VlcPlayer(
                    controller: _vlcPlayerController,
                    aspectRatio: 16 / 9,
                    placeholder: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 60,
                width: 280.w,
                child: TextField(
                  controller: caption,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    hintText: 'Write a caption ...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const Divider(),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: isLoading ? null : () {
                      // Handle save draft logic
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 45.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        'Save draft',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        String reelsUrl = await StorageMethod()
                            .uploadImageToStorage(
                            'Reels', widget.videoFile);
                        await Firebase_Firestor().CreatReels(
                          video: reelsUrl,
                          caption: caption.text,
                        );
                        Navigator.of(context).pop();
                      } catch (e) {
                        _showErrorSnackBar('Failed to share reel. Please try again.');
                      } finally {
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 45.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : Text(
                        'Share',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
