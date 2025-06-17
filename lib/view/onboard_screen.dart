import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:task/constance/color_constant.dart';
import 'package:task/view/signin_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> pages = [
    {
     
      "texts": ["Welcome to", "Seclob", "Start growing your business with our platform — track sales, manage clients, and maximize profits."],
      "image": "asset/images/svg/Send money abroad.svg"
    },
    {
            "texts": ["Manage Your Partners", "Seamlessly", "Add, view, and collaborate with your team or resellers, all from a single dashboard."],
      "image": "asset/images/svg/Trust.svg"
    },
    {
    
      "texts": ["Analyze & Boost Your ", "Earnings", "Get real-time reports, track performance, and maximize incentives with ease."],
      "image": "asset/images/svg/Receive Money.svg"
    },
  ];

  void _nextPage() {
    if (_currentPage < pages.length - 1) {
      _controller.nextPage(
          duration: Duration(milliseconds: 500), curve: Curves.ease);
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen(),));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemBuilder: (_, index) {
                final page = pages[index];
                return Column(
                    children: [
                      SizedBox(height: 70.h,),
                    Container(
                      
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    // First Text
    Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8),
      child: Text(
        page["texts"][0],
        style: TextStyle(
          fontSize: 28.sp,
          fontWeight: FontWeight.w500,
          color: Color(0xff333333),
        ),
      ),
    ),

    // Second Text inside a decorated Container
    Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: Color(0xFFC4A3FF), // background color
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Text(
          page["texts"][1],
          style: TextStyle(
            fontSize: 20.sp,
            color: kPrimaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),

    // Third Text
    Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        page["texts"][2],
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    ),
  ],
),

                    ),
                    SizedBox(height: 52.h,),

                    Expanded(child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 30.w,),
                      child: SvgPicture.asset(page["image"],),
                    )),
                  ],
                );
              },
            ),
          ),
                              SizedBox(height: 52.h),

          SmoothPageIndicator(
  controller: _controller,
  count: pages.length,
  effect: CustomizableEffect(
    activeDotDecoration: DotDecoration(
      width: 16.w,
      height: 8.h,
      color: kPrimaryColor,
      borderRadius: BorderRadius.circular(6),
    ),
    dotDecoration: DotDecoration(
      width: 37.w, // 👈 Inactive dot width greater than active
      height: 8.h,
      color: Colors.grey.shade300,
      borderRadius: BorderRadius.circular(6),
    ),
    spacing: 8.0,
  ),
),
SizedBox(height: 52.h,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 30.w),
            child: ElevatedButton(
              onPressed: _nextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding: EdgeInsets.symmetric(vertical: 14),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                _currentPage == pages.length - 1 ? "Sign In" : "Next",
                style: TextStyle(fontSize: 16.sp,color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 52.h,),

        ],
      ),
    );
  }
}
