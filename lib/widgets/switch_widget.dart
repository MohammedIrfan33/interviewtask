

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task/constance/color_constant.dart';

class SwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const SwitchTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return  Row(
        children: [
          Icon(icon, size: 30.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Transform.scale(
            scale: 0.75, // Adjust this value to control height/size
            child: Switch(
              value: value,
              onChanged: onChanged,
              thumbColor: MaterialStateProperty.all(Colors.white),
              trackColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return kPrimaryColor;
                }
                return Colors.grey.withOpacity(0.3);
              }),
              trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
            ),
          ),
        ],
    
    );
  }
}
