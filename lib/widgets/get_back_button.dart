import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GetBackButton extends StatelessWidget {
  final double width;
  final double height;
  const GetBackButton({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Icon(
          Icons.arrow_back_ios,
          size: 20.h,
          color: Colors.white,
        ),
      ),
    );
  }
}
