import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';

class CustomTabItemWidget<T> extends StatelessWidget {
  const CustomTabItemWidget(
      {super.key, required this.title, this.value, this.selectedValue});

  final String title;
  final T? value;
  final T? selectedValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 7.h),
        decoration: BoxDecoration(
            color: selectedValue == value
                ? AppColors.greenColor
                : AppColors.transparentColor,
            borderRadius: BorderRadius.circular(33.r)),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 15.sp,
              color: selectedValue == value
                  ? AppColors.whiteColor
                  : AppColors.greenColor),
        ),
      ),
    );
  }
}
