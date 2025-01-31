import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';

class CustomContainer extends StatelessWidget {
  final Color? conatinerColor, iconColor, fontColor;
  final double? height, width, iconHeight, iconWidth, fontSize;
  final String? iconImage, text;
  final FontWeight? fontWeight;
  final BoxShape shape;
  final void Function()? onTap;
  final IconData? iconData;
  final BorderRadiusGeometry? borderRadius;
  final DecorationImage? decortionImage;
  final BoxBorder? boxBorder;

  const CustomContainer({
    super.key,
    this.conatinerColor,
    this.iconColor,
    this.height,
    this.width,
    this.iconHeight,
    this.iconWidth,
    this.fontSize,
    this.iconImage,
    this.text,
    this.shape = BoxShape.circle,
    this.fontWeight,
    this.onTap,
    this.iconData,
    this.fontColor = AppColors.whiteColor,
    this.borderRadius,
    this.decortionImage,
    this.boxBorder,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? 155.w,
        height: height ?? 155.w,
        decoration: BoxDecoration(
            border: boxBorder,
            image: decortionImage,
            shape: shape,
            color: conatinerColor,
            borderRadius: borderRadius),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconImage != null)
              // Icon(Icons.abc)
              Image.asset(
                iconImage!,
                color: iconColor,
                width: iconWidth ?? 46.w,
                height: iconHeight ?? 46.w,
              ),
            if (iconData != null)
              Icon(
                iconData!,
                color: iconColor,
                size: iconWidth,
              ),
            if (text != null) ...[
              10.verticalSpace,
              Text(
                text ?? '',
                style: TextStyle(
                  fontSize: fontSize ?? 18.sp,
                  fontWeight: fontWeight ?? FontWeight.w500,
                  color: fontColor!,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
