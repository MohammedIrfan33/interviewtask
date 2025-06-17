import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:task/constance/color_constant.dart';

class CarouselBanner extends StatefulWidget {
  const CarouselBanner({super.key});

  @override
  State<CarouselBanner> createState() => _CarouselBannerState();
}

class _CarouselBannerState extends State<CarouselBanner> {
  int _activeIndex = 0;

  final List<String> _images = [
    'asset/images/banner.png',
    'asset/images/banner.png',
    'asset/images/banner.png',
    'asset/images/banner.png',
    
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _images.length,
          itemBuilder: (context, index, realIdx) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                _images[index],
                fit: BoxFit.cover,
                width: 1.sw,
              ),
            );
          },
          options: CarouselOptions(
            height: 140.h,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _activeIndex = index;
              });
            },
          ),
        ),
        SizedBox(height: 10.h),
       AnimatedSmoothIndicator(
  activeIndex: _activeIndex,
  count: _images.length,
  effect: SlideEffect(
    dotHeight: 8.h,
    dotWidth: 8.h,
    spacing: 8.w,
    activeDotColor: kSecondaryColor,
    dotColor: kTextGrey,
  ),
)

      ],
    );
  }
}
