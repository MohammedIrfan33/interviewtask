import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:task/constance/color_constant.dart';
import 'package:task/view/profile_details.dart';
import 'package:task/view_model/auth_view_model.dart';
import 'package:task/widgets/option_tile.dart';
import 'package:task/widgets/switch_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<AuthViewModel>().getUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authVM = context.watch<AuthViewModel>();
    final profile = authVM.userProfile;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        toolbarHeight: 80.h,
        leading: IconButton(
          icon: Icon(LucideIcons.arrowLeft, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: authVM.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
                      margin: EdgeInsets.symmetric(vertical: 25.h),
                      decoration: BoxDecoration(
                        color: kSecondaryColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 32.r,
                            backgroundImage: AssetImage('asset/images/Avatar.png'),
                          ),
                          SizedBox(width: 16.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profile?.name ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                profile?.email ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            
                    Text(
                  "Account",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  )),
            
                  SizedBox(height: 15.h,),
            
                     OptionTile(
                  icon: 'asset/images/svg/person.svg',
                  title: 'Profile',
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileDetailsScreen(),));
                  },
                ),
            
            
                SwitchTile(
                  icon: 'asset/images/svg/mode.svg',
                  title: 'Dark Mode',
                  value: false,
                  onChanged: (value) {
                    
                  },
                ),
                SwitchTile(
                  icon: 'asset/images/svg/notify.svg',
                  title: 'Notifications',
                  value: false,
                  onChanged: (value) {
                    
                  },
                ),
                OptionTile(
                  icon: 'asset/images/svg/bank.svg',
                  title: 'Bank Account',
                  onTap: () {
                  },
                ),
            
            
                OptionTile(
                  icon: 'asset/images/svg/hs.svg',
                  title: 'Help & Support',
                  onTap: () {
                  },
                ),
            
                OptionTile(
                  icon: 'asset/images/svg/cp.svg',
                  title: 'Consumer  policies',
                  onTap: () {
                  },
                ),
            
            
                Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                    ),
                    builder: (_) => const LogoutConfirmationSheet(),
                  );
                },
                borderRadius: BorderRadius.circular(10.r),
                child: Row(
                  children: [
                    SvgPicture.asset('asset/images/svg/logout.svg',height: 24.h,width: 24.h,),
                    SizedBox(width: 12.w),
                    Text(
            'Logout',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Colors.red,
            ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 60,)
            
                
                  ],
                ),
              ),
          ),
    );
  }
}


class LogoutConfirmationSheet extends StatelessWidget {
  const LogoutConfirmationSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'asset/images/svg/ficon.svg', // Replace with your image path
            height: 48.h,
          ),
          SizedBox(height: 16.h),
          Text(
            'Log out?',
            style: TextStyle(
              fontWeight: FontWeight.w600, // Approx 510
              fontSize: 18.sp,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Are you sure you want to log out?',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade300),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);

                    context.read<AuthViewModel>().logoutUser(context);

                  },
                  child: Text(
                    'Log out',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

