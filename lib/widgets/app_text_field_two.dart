import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/colors.dart';

class AppTextFieldTwo extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final bool isObscure;
  final textInputType;
  final bool enabled;
  final bool readOnly;
  Function(String)? onChanged;
  final int minLines;
  final int maxLines;
  final double height;

  AppTextFieldTwo(
      {super.key,
      required this.textController,
      required this.hintText,
      this.textInputType,
      this.isObscure = false,
      this.enabled = true,
      this.minLines = 1,
      this.maxLines = 1,
      this.height = 52,
      this.onChanged,
      this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      child: TextField(
        minLines: minLines,
        maxLines: maxLines,
        enabled: enabled,
        readOnly: readOnly,
        controller: textController,
        onChanged: onChanged,
        obscureText: isObscure,
        keyboardType: textInputType,
        style: GoogleFonts.montserrat(),
        decoration: InputDecoration(
          // contentPadding: EdgeInsets.all(16.r),
          // hintStyle:TextStyle(color: commentTextFileBOrder),
          labelStyle: GoogleFonts.montserrat(
              color: enabled ? Colors.black : Colors.black,
              fontSize: MediaQuery.of(context).size.height / 42.2),
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
          hintStyle: TextStyle(
            color: appBrownColor,
            fontSize: 10.sp,
            fontWeight: FontWeight.w400,
          ),

          filled: true,
          fillColor: subscriptionCardColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(74.r),
            borderSide: const BorderSide(
              width: 2.0,
              color: subscriptionCardColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(74.r),
            borderSide: BorderSide(
              color: subscriptionCardColor,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(
              width: 2.0,
              color: appWhiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
