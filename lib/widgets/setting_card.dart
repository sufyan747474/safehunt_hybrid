import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_hunt/utils/colors.dart';

import 'big_text.dart';

class SettingCard extends StatelessWidget {
  final String label;
  final String svgPicture;
  final void Function()? onTap;

  const SettingCard({
    super.key,
    required this.label,
    required this.svgPicture,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            BigText(
              text: label,
              color: appBrownColor,
              size: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            Spacer(),
            SvgPicture.asset(svgPicture),
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
      ),
    );
  }
}
