import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:isntragram_clone/util/image_cached.dart';
import '../data/firebase_services/firestore.dart';
import 'comment.dart';
import 'like_animation.dart';

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
  bool isAnimating = false;
  String user = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    user = _auth.currentUser!.uid;

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

  Future<int> getCommentCount() async {
    QuerySnapshot commentSnapshot = await FirebaseFirestore
        .instance
        .collection('reels')
        .doc(widget.snapshot['postId'])
        .collection('comments')
        .get();

    return commentSnapshot.size; // Returns the number of documents (comments)
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        InkWell(
          onDoubleTap: () {
            Firebase_Firestor().like(
                like: widget.snapshot['like'],
                type: 'reels',
                uid: user,
                postId: widget.snapshot['postId']);
            setState(() {
              isAnimating = true;
            });
          },
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
        Center(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isAnimating ? 1 : 0,
            child: LikeAnimation(
              isAnimating: isAnimating,
              duration: const Duration(milliseconds: 400),
              iconlike: false,
              End: () {
                setState(() {
                  isAnimating = false;
                });
              },
              child: Icon(
                Icons.favorite,
                size: 100.w,
                color: Colors.red,
              ),
            ),
          ),
        ),
        Positioned(
          top: 430.h,
          right: 15.w,
          child: Column(
            children: [
              LikeAnimation(
                child: IconButton(
                  onPressed: () {
                    Firebase_Firestor().like(
                        like: widget.snapshot['like'],
                        type: 'reels',
                        uid: user,
                        postId: widget.snapshot['postId']);
                  },
                  icon: Icon(
                    widget.snapshot['like'].contains(user)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: widget.snapshot['like'].contains(user)
                        ? Colors.red
                        : Colors.white,
                    size: 24.w,
                  ),
                ),
                isAnimating: widget.snapshot['like'].contains(user),
              ),
              SizedBox(height: 3.h),
              Text(
                widget.snapshot['like'].length.toString(),
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 15.h),
              GestureDetector(
                onTap: () {
                  showBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: DraggableScrollableSheet(
                          maxChildSize: 0.6,
                          initialChildSize: 0.6,
                          minChildSize: 0.2,
                          builder: (context, scrollController) {
                            return Comment('reels', widget.snapshot['postId']);
                          },
                        ),
                      );
                    },
                  );
                },
                child: Icon(
                  Icons.comment,
                  color: Colors.white,
                  size: 28.w,
                ),
              ),
              SizedBox(height: 3.h),
              FutureBuilder<int>(
                future: getCommentCount(), // Call the method that fetches comment count
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text(
                      'Loading...',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      'Error',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                      ),
                    );
                  } else {
                    return Text(
                      snapshot.data.toString(), // Display the comment count
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.white,
                      ),
                    );
                  }
                },
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
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white,
                ),
              ),
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
