import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({super.key});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 375.w,
          height: 54.h,
          color: Colors.white,
          child: Center(
            child: ListTile(
              leading: ClipOval(
                child: SizedBox(
                  width: 35.w,
                  height: 35.h,
                  child: Image.asset('assets/images/person.png'),
                ),
              ),
              title: Text(
                "Username",
                style: TextStyle(fontSize: 13.sp),
              ),
              subtitle: Text(
                "Location",
                style: TextStyle(fontSize: 11.sp),
              ),
              trailing: Icon(Icons.more_horiz),
            ),
          ),
        ),
        SizedBox(height: 5.h,),
        Container(
          height: 375.h,
          width: 375.w,
          child: Image.asset(
            'assets/images/post.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: 375.w,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 14.h),
              Row(
                children: [
                  SizedBox(width: 14.w),
                  Icon(
                    Icons.favorite_outline,
                    size: 25.w,
                  ),
                  SizedBox(width: 17.w),
                  Image.asset(
                    'assets/images/comment.webp',
                    height: 28.h,
                  ),
                  SizedBox(width: 17.w),
                  Image.asset(
                    'assets/images/send.jpg',
                    height: 28.h,
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: 15.w),
                    child: Image.asset(
                      'assets/images/save.png',
                      height: 28.h,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 19.w, top: 13.5.h, bottom: 5.h),
                  child: Text(
                    '0',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Row(
                  children: [
                    Text(
                      "Username",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.sp),
                    ),
                    Text(
                      "caption",
                      style: TextStyle(fontSize: 13.sp),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 15.w, top: 20.h, bottom: 8.h,),
                  child: Text(
                    "Dtaeformat",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );;
  }
}
