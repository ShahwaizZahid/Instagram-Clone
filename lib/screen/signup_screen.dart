import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupScreen extends StatefulWidget {
  final VoidCallback show;
  SignupScreen(this.show, {super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final email = TextEditingController();
  FocusNode email_F = FocusNode();
  final password = TextEditingController();
  FocusNode password_F = FocusNode();
  final passwordConfirme = TextEditingController();
  FocusNode passwordConfirme_F = FocusNode();
  final username = TextEditingController();
  FocusNode username_F = FocusNode();
  final bio = TextEditingController();
  FocusNode bio_F = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 100.h,
            width: 96.w,
          ),
          Center(
            child: Image.asset('assets/images/logo.jpg'),
          ),
          SizedBox(height: 60.h,),
          InkWell(
            onTap: () async {
              // File _imagefilee = await ImagePickerr().uploadImage('gallery');
              // setState(() {
              //   _imageFile = _imagefilee;
              // });
            },
            child: CircleAvatar(
              radius: 36.r,
              backgroundColor: Colors.grey,
              child:CircleAvatar(
                radius: 34.r,
                backgroundImage: AssetImage('assets/images/person.png'),
                backgroundColor: Colors.grey.shade200,
              )
            ),
          ),
          SizedBox(height: 50.h),
          Textfild(email, email_F, 'Email', Icons.email),
          SizedBox(height: 15.h),
          SizedBox(height: 15.h),
          Textfild(username, username_F, 'username', Icons.person),
          SizedBox(height: 15.h),
          Textfild(bio, bio_F, 'bio', Icons.abc),
          SizedBox(height: 15.h),
          Textfild(password, password_F, 'Password', Icons.lock),
          SizedBox(height: 15.h),
          Textfild(passwordConfirme, passwordConfirme_F, 'PasswordConfirme',
              Icons.lock),
          SizedBox(height: 20.h),
          Signup(),
          SizedBox(height: 10.h),
          Haveaccount()
        ],
      )),
    );
  }

  Widget Textfild(TextEditingController controll, FocusNode focusNode,
      String typename, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        height: 44.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: TextField(
          style: TextStyle(fontSize: 18.sp, color: Colors.black),
          controller: controll,
          focusNode: focusNode,
          decoration: InputDecoration(
            hintText: typename,
            prefixIcon: Icon(
              icon,
              color: focusNode.hasFocus ? Colors.black : Colors.grey[600],
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(
                width: 2.w,
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(
                width: 2.w,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget Signup() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: InkWell(
        onTap: () async {
          // await Authentication()
          //     .Login(email: email.text, password: password.text);
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 44.h,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            'Signup',
            style: TextStyle(
              fontSize: 23.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget Haveaccount() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Don't have account?  ",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: widget.show,
            child: Text(
              "Login ",
              style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
