import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../utils/colors.dart';

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
        padding: EdgeInsets.only(left: 8.0),
        child: Icon(
          Icons.arrow_back_ios,
          size: 20.h,
          color: Colors.white,
        ),
      ),
    );
  }
}
