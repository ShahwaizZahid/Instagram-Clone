import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:isntragram_clone/util/image_cached.dart';
import 'package:video_player/video_player.dart';

class ReelsItem extends StatefulWidget {
  final dynamic snapshot;
  ReelsItem(this.snapshot, {super.key});

  @override
  State<ReelsItem> createState() => _ReelsItemState();
}

class _ReelsItemState extends State<ReelsItem> {
  late VlcPlayerController _vlcPlayerController;
  bool isPlaying = true;
  int playCount = 0;
  final int maxPlays = 2;
  Timer? _restartTimer;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    _vlcPlayerController = VlcPlayerController.network(
      widget.snapshot['reelsvideo'],
      autoPlay: true,
      options: VlcPlayerOptions(
        extras: [],
      ),
    );
  }

  @override
  void dispose() {
    _vlcPlayerController.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (isPlaying) {
        _vlcPlayerController.pause();
      } else {
        _vlcPlayerController.play();
      }
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        InkWell(
          onTap: _togglePlayPause,
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: VlcPlayer(
              controller: _vlcPlayerController,
              aspectRatio: 16 / 9,
              placeholder: const Center(
                child: CupertinoActivityIndicator(),
              ),
            ),
          ),
        ),
        if (!isPlaying)
          Center(
            child: CircleAvatar(
              backgroundColor: Colors.white30,
              radius: 35.r,
              child: Icon(
                Icons.play_arrow,
                size: 35.w,
                color: Colors.white,
              ),
            ),
          ),
        Positioned(
          top: 430.h,
          right: 15.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.favorite_border,
                color: Colors.white,
                size: 28.w,
              ),
              SizedBox(height: 3.h),
              Text(
                '0',
                style: TextStyle(fontSize: 12.sp, color: Colors.white),
              ),
              SizedBox(height: 15.h),
              Icon(
                Icons.comment,
                color: Colors.white,
                size: 28.w,
              ),
              SizedBox(height: 3.h),
              Text(
                '0',
                style: TextStyle(fontSize: 12.sp, color: Colors.white),
              ),
              SizedBox(height: 15.h),
              Icon(
                Icons.send,
                color: Colors.white,
                size: 28.w,
              ),
              SizedBox(height: 3.h),
              Text(
                '0',
                style: TextStyle(fontSize: 12.sp, color: Colors.white),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 40.h,
          left: 10.w,
          right: 0,
          child: Column(
            children: [
              Row(
                children: [
                  ClipOval(
                    child: SizedBox(
                      height: 35.h,
                      width: 35.w,
                      child: CachedImage(widget.snapshot['profileImage']),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(widget.snapshot['username'],
                      style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  SizedBox(width: 10.w),
                  Container(
                    alignment: Alignment.center,
                    width: 60.w,
                    height: 25.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Text(
                      'Follow',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                widget.snapshot['caption'],
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
