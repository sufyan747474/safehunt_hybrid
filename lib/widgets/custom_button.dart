import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/colors.dart';
import 'big_text.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Color color;
  final bool isLoading;
  Border? border;
  Color? textColor;
  FontWeight fontWeight;
  CustomButton(
      {super.key,
      required this.text,
      this.color = appButtonWhiteColor,
      this.isLoading = false,
      this.textColor,
      this.fontWeight = FontWeight.normal,
      this.border});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(30.r),
        border: widget.border,
      ),
      child: Center(
          child: BigText(
        text: widget.text,
        size: 14.72.sp,
        fontWeight: FontWeight.w500,
        color: widget.textColor,
      )),
    );
  }
}
