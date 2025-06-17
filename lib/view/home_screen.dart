import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:task/constance/color_constant.dart';
import 'package:task/view_model/home_view_model.dart';
import 'package:task/widgets/carousel_banner.dart';
import 'package:task/widgets/featured_card_tile.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  final List<Map<String, dynamic>> features = [
  {
    'icon': 'asset/images/e-card.png',
    'label': 'E-card',
  },
  {
    'icon': 'asset/images/hr.png',
    'label': 'HR insight',
  },
  {
    'icon': 'asset/images/recharge.png',
    'label': 'Recharge',
    'badge': 'Get 10% Extra',
  },
  {
    'icon': 'asset/images/dth 1.png',
    'label': 'DTH/Cable',
  },
];


  @override
  Widget build(BuildContext context) {
    final homeVM = context.watch<HomeViewModel>();
    final userName = homeVM.userName;
    final balance = homeVM.balance;
    final isLoading = homeVM.isLoading;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      
      body: CustomScrollView(
        slivers: [

          // First Section with background image + balance info
          SliverToBoxAdapter(
            child: Stack(
              children: [
                
                Container(
                  height: 0.36.sh,
                  width: 1.sw,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("asset/images/bg1.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Positioned(
                  top: 45.h,
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Hey $userName! 👋",
                                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 22.sp,
                    color: Colors.black,
                                  ),
                                ),
                              SvgPicture.asset('asset/images/svg/Notification.svg',height: 24,width: 24,)
                                
                              ],
                            ),
                  ),
                ),
                Positioned(
                  bottom: 15.h,
                  left: 24.w,
                  right: 24.w,
                  child: Container(
                    
                    child: isLoading
    ? Center(child: CircularProgressIndicator())
    : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Available balance",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500, // Approximating 510 weight
              color: Colors.black,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            balance != null ? "₹ ${balance.toStringAsFixed(2)}" : "₹ --",
            style: TextStyle(
              fontSize: 48.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          )
          
          ,
          SizedBox(height: 10.h,),

          SizedBox(
      height: 40.h,
      child: ElevatedButton.icon(
        onPressed: () {
          
        },
        icon: Icon(Icons.add,color: Colors.white,size: 20,),
        style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        label: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                 'Add',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
      ),
    )
  
        ],
      ),

                
                
                  ),
                ),
              ],
            ),
          ),

         SliverToBoxAdapter(
  child: Container(

    color: Colors.white,
    child: Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           SizedBox(height: 10.h,),
          const CarouselBanner(), // 🔁 Refactored widget here
        
          // your GridView or other widgets here

          SizedBox(height: 10.h,),

          Text("Service",style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500
          ),),
                SizedBox(height: 10.h,),

          GridView.builder(
            padding: EdgeInsets.zero,
            itemCount: features.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
              childAspectRatio: 2,
            ),
            itemBuilder: (context, index) {
              final feature = features[index];
              return FeatureCardTile(
                icon: feature['icon'],
                label: feature['label'],
                badge: feature['badge'],
              );
            },
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            width: double.maxFinite,
            child: Image.asset('asset/images/refer.png'))
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
