// UPDATED SignInScreen with loading controlled by ViewModel

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:task/constance/color_constant.dart';
import 'package:task/utils/validator.dart';
import 'package:task/view/root_screen.dart';
import 'package:task/view_model/auth_view_model.dart';
import 'package:task/widgets/custom_text_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final provider = Provider.of<AuthViewModel>(context, listen: false);
      final result = await provider.loginUser(
        _emailController.text.trim(),
        _passwordController.text.trim(),
        context
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result ?? 'Login failed')),
      );

      if (result == "Login success") {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RootScreen(),), (route) => false,);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              color: kPrimaryColor,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset("asset/images/svg/logo.svg", height: 33.h),
                    SizedBox(height: 16.h),
                    Text(
                      "Welcome Back!",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 24.sp,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "Welcome back to your workspace.",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 30.h),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      hint: "Enter email",
                      controller: _emailController,
                      iconData: LucideIcons.mail,
                      validator: Validators.validateEmail,
                    ),
                    SizedBox(height: 10.h),
                    CustomTextField(
                      hint: "Enter password",
                      controller: _passwordController,
                      iconData: LucideIcons.lock,
                      validator: Validators.validatePassword,
                    ),
                    SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    
                    SizedBox(
                      width: double.infinity,
                      height: 44.h,
                      child: ElevatedButton(
                        onPressed: viewModel.isLoading ? null : _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: viewModel.isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                "Log in",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                   
                   
                    Spacer(),
                    Text(
                      "Or log in with",
                      style: TextStyle(
                        color: kTextGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("asset/images/svg/google.svg", height: 24.h, width: 24.h),
                        SizedBox(width: 20.w),
                        SvgPicture.asset("asset/images/svg/fb.svg", height: 24.h, width: 24.h),
                        SizedBox(width: 20.w),
                        Container(
                          margin: EdgeInsets.only(bottom: 2),
                          height: 28.h,
                          width: 28.h,
                          child: Image.asset("asset/images/apple.png", fit: BoxFit.contain,)),
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Don't have an account? Sign Up",
                        style: TextStyle(color: kPrimaryColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}