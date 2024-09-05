import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../data/firebase_services/firebase_auth.dart';
import '../util/exception.dart';

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

  bool _isLoading = false;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100.h),
              Center(child: Image.asset('assets/images/logo.jpg')),
              SizedBox(height: 120.h),
              _buildTextField(email, email_F, 'Email', Icons.email),
              SizedBox(height: 15.h),
              _buildTextField(password, password_F, 'Password', Icons.lock),
              SizedBox(height: 15.h),
              _buildForgetPassword(),
              SizedBox(height: 15.h),
              _buildLoginButton(),
              SizedBox(height: 15.h),
              _buildHaveAccount(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, FocusNode focusNode, String hintText, IconData icon) {
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
          obscureText: hintText == 'Password',
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon, color: focusNode.hasFocus ? Colors.black : Colors.grey[600]),
            contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(width: 2.w, color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(width: 2.w, color: Colors.black),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(width: 2.w, color: Colors.red),
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
        },
        child: Text(
          'Forgot password?',
          style: TextStyle(fontSize: 13.sp, color: Colors.blue, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: InkWell(
        onTap: () async {
          setState(() {
            _errorMessage = '';
            _isLoading = true;
          });

          if (email.text.isEmpty || password.text.isEmpty) {
            setState(() {
              _errorMessage = 'Please enter both email and password';
              _isLoading = false;
            });
            return;
          }

          try {
            await Authentication().Login(
              email: email.text,
              password: password.text,
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Login successful!'),
                backgroundColor: Colors.green,
              ),
            );

            // Navigate to another screen if needed
          } on exceptions catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(e.message),
                backgroundColor: Colors.red,
              ),
            );
            setState(() {
              _errorMessage = e.message;
            });
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('An unexpected error occurred'),
                backgroundColor: Colors.redAccent,
              ),
            );
            setState(() {
              _errorMessage = e.toString();
            });
          } finally {
            setState(() {
              _isLoading = false;
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
              ? CircularProgressIndicator(color: Colors.white)
              : Text(
            'Login',
            style: TextStyle(fontSize: 23.sp, color: Colors.white, fontWeight: FontWeight.bold),
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
            style: TextStyle(fontSize: 14.sp, color: Colors.grey),
          ),
          GestureDetector(
            onTap: widget.show,
            child: Text(
              "Sign up ",
              style: TextStyle(fontSize: 15.sp, color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
