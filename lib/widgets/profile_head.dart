import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/firebase_services/firestore.dart';
import '../data/model/usermodel.dart';
import '../util/image_cached.dart';

class ProfileHead extends StatefulWidget {
  final Usermodel user;
  final Uid;
  bool isCurrentUser = false;
  bool follow = false;
  ProfileHead({super.key, required this.user, required this.follow, required this.isCurrentUser, required this.Uid,});

  @override
  State<ProfileHead> createState() => _ProfileHeadState();
}

class _ProfileHeadState extends State<ProfileHead> {
  @override
  Widget build(BuildContext context) {

      return Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 10.h),
                  child: ClipOval(
                    child: SizedBox(
                      width: 80.w,
                      height: 80.h,
                      child: CachedImage(widget.user.profile),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 20.w),
                        Column(
                          children: [
                            Text(
                              '0', // Update with actual post count if needed
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                            Text(
                              'Posts',
                              style: TextStyle(
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 25.w),
                        Column(
                          children: [
                            Text(
                              widget.user.followers.length.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                            Text(
                              'Followers',
                              style: TextStyle(
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 25.w),
                        Column(
                          children: [
                            Text(
                              widget.user.following.length.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                              ),
                            ),
                            Text(
                              'Following',
                              style: TextStyle(
                                fontSize: 13.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user.username,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Text(
                    widget.user.bio,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Visibility(
              visible: !widget.follow,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.w),
                child: GestureDetector(
                  onTap: () {
                    if (!widget.isCurrentUser) {
                      Firebase_Firestor().flollow(uid: widget.Uid);
                      setState(() {
                        widget.follow = true;
                      });
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 30.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: widget.isCurrentUser ? Colors.white : Colors.blue,
                      borderRadius: BorderRadius.circular(5.r),
                      border: Border.all(
                          color:widget.isCurrentUser ? Colors.grey.shade400 : Colors.blue),
                    ),
                    child:widget.isCurrentUser
                        ? Text('Edit Your Profile')
                        : Text(
                      'Follow',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: widget.follow,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.w),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Firebase_Firestor().flollow(uid: widget.Uid);
                          setState(() {
                            widget.follow = false;
                          });
                        },
                        child: Container(
                            alignment: Alignment.center,
                            height: 30.h,
                            width: 100.w,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(5.r),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Text('Unfollow')),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        height: 30.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(5.r),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Text(
                          'Message',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5.h),
          ],
        ),
      );
    }
  }

