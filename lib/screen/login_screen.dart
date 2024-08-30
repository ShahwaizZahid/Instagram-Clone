import 'dart:async'; // Import for Timer (if you use it for any delay or animation)
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/firebase_services/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback show;
  LoginScreen(this.show, {super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  FocusNode email_F = FocusNode();
  final password = TextEditingController();
  FocusNode password_F = FocusNode();

  bool _isLoading = false; // Track loading state
  String _errorMessage = ''; // Track error message

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
            SizedBox(height: 120.h),
            _buildTextField(email, email_F, 'Email', Icons.email),
            SizedBox(height: 15.h),
            _buildTextField(password, password_F, 'Password', Icons.lock),
            SizedBox(height: 15.h),
            _buildForgetPassword(),
            SizedBox(height: 15.h),
            _buildLoginButton(),
            SizedBox(height: 15.h),
            _buildHaveAccount()
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, FocusNode focusNode,
      String hintText, IconData icon) {
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
          controller: controller,
          focusNode: focusNode,
          obscureText: hintText == 'Password', // Hide password text
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(
              icon,
              color: focusNode.hasFocus ? Colors.black : Colors.grey[600],
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
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

  Widget _buildForgetPassword() {
    return Padding(
      padding: EdgeInsets.only(left: 230.w),
      child: GestureDetector(
        onTap: () {
          // Handle password reset
          // Navigate to password reset screen or show dialog
        },
        child: Text(
          'Forgot password?',
          style: TextStyle(
            fontSize: 13.sp,
            color: Colors.blue,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: InkWell(
        onTap: () async {
          if (_isLoading) return; // Prevent multiple taps

          setState(() {
            _errorMessage = ''; // Clear previous error message
            _isLoading = true; // Set loading state
          });

          // Validate input
          if (email.text.isEmpty || password.text.isEmpty) {
            setState(() {
              _errorMessage = 'Please enter both email and password';
              _isLoading = false; // Reset loading state
            });
            return;
          }

          try {
            await Authentication().Login(
              email: email.text,
              password: password.text,
            );
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Login successful!'),
                backgroundColor: Colors.green, // Customize the background color here
              ),
            );
            // Navigate to another screen if needed
          } on FirebaseException catch(e){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.code),
                backgroundColor: Colors.red, // Customize the background color here
              ),
            );

          }catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Errro in login"),
                backgroundColor: Colors.redAccent
                , // Customize the background color here
              ),
            );
            setState(() {
              _errorMessage = e.toString();
            });
          } finally {
            setState(() {
              _isLoading = false; // Reset loading state
            });
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 44.h,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: _isLoading
              ? CircularProgressIndicator(
            color: Colors.white,
          )
              : Text(
            'Login',
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

  Widget _buildHaveAccount() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Don't have an account?  ",
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey,
            ),
          ),
          GestureDetector(
            onTap: widget.show,
            child: Text(
              "Sign up ",
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
