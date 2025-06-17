import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task/view_model/auth_view_model.dart';
import 'package:task/constance/color_constant.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<AuthViewModel>().userProfile;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Text(
          'My Profile',
          style: TextStyle(fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: profile == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  // Profile Header
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 20.w),
                    decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 36.r,
                          backgroundImage: AssetImage('asset/images/Avatar.png'), // Replace with dynamic image if needed
                        ),
                        SizedBox(width: 16.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile.name,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              profile.email,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),

                  // Info Card
                  _infoCard("User ID", profile.name),
                  _infoCard("Phone", profile.phone ?? "Not provided"),
                  _infoCard("Gender", profile.country ?? "Not specified"),
                  _infoCard("Address", profile.address.city ?? "No address"),
                ],
              ),
            ),
    );
  }

  Widget _infoCard(String title, String value) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.grey[700])),
            Expanded(
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
