import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_hunt/utils/colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final bool isObscure;
  final TextInputType? keyboardType;
  final bool enabled;
  final bool readOnly;
  Function(String)? onChanged;
  final int minLines;
  final int maxLines;
  final double height;
  final String? Function(String?)? validator;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final bool isSuffixIcons;
  final Widget? suffixIcon;

  AppTextField(
      {super.key,
      this.suffixIcon,
      this.isSuffixIcons = false,
      required this.textController,
      required this.hintText,
      this.keyboardType,
      this.isObscure = false,
      this.enabled = true,
      this.minLines = 1,
      this.maxLines = 1,
      this.height = 52,
      this.onChanged,
      this.validator,
      this.maxLength,
      this.inputFormatters,
      this.readOnly = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: height.h,
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        validator: validator,
        minLines: minLines,
        maxLines: maxLines,
        enabled: enabled,
        readOnly: readOnly,
        controller: textController,
        onChanged: onChanged,
        obscureText: isObscure,
        keyboardType: keyboardType,
        style: GoogleFonts.montserrat(
          color: Colors.white,
        ),
        decoration: InputDecoration(
          counterText: '',
          // contentPadding:  EdgeInsets.all(16.r),
          // hintStyle:TextStyle(color: Colors.red),
          labelStyle: GoogleFonts.montserrat(
              color: enabled ? Colors.white : Colors.white,
              fontSize: MediaQuery.of(context).size.height / 42.2),
          hintText: hintText,

          contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
          hintStyle: TextStyle(
            color: appGreyColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),

          filled: true,
          fillColor: appDarkGreenColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(74.r),
            borderSide: const BorderSide(
              width: 2.0,
              color: appDarkGreenColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(74.r),
            borderSide: const BorderSide(
              color: appDarkGreenColor,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(
              width: 2.0,
              color: appWhiteColor,
            ),
          ), //----------------------------sufux Icon---------------------//
          // suffixIconConstraints: BoxConstraints.tight(Size(40.w, 48.w)),
          suffixIcon: isSuffixIcons
              ? Container(
                  margin: EdgeInsets.only(
                      right: 0.w), // Adjust the margin as needed
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      suffixIcon!,
                    ],
                  ))
              : null,
        ),
      ),
    );
  }
}
