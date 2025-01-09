import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'big_text.dart';

class DrawerCard extends StatelessWidget {
  final String label;
  final String svgPicture;
  Color? color;
  double size;
  FontWeight fontWeight;

  DrawerCard(
      {super.key,
      required this.label,
      required this.svgPicture,
      this.color = const Color(0xFFFFFFFF),
      this.size = 15.0,
      this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(svgPicture),
          SizedBox(
            width: 20.w,
          ),
          BigText(
            text: label,
            color: color,
            size: size,
            fontWeight: fontWeight,
          ),
          SizedBox(
            height: 10.h,
          ),
          // Container(
          //   height: 1,
          //   width: MediaQuery.of(context).size.width ,
          //   color: Colors.grey,
          // )
        ],
      ),
    );
  }
}
