import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_hunt/model/content_model.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/colors.dart';
import 'package:safe_hunt/utils/utils.dart';
import 'package:safe_hunt/widgets/big_text.dart';

class ContentScreen extends StatelessWidget {
  final ContentData termsData;

  const ContentScreen({super.key, required this.termsData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: appButtonColor,
        leading: Padding(
          padding: EdgeInsets.all(8.0.w),
          child: GestureDetector(
            onTap: () {
              AppNavigation.pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 23.sp,
              color: Colors.black,
            ),
          ),
        ),
        titleSpacing: -10,
        title: BigText(
          text: termsData.title,
          size: 16.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigText(
              text:
                  'Last Updated: ${Utils.formattedDate(date: termsData.lastUpdated)}',
              size: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: SingleChildScrollView(
                child: BigText(
                    textAlign: TextAlign.start,
                    text: termsData.content,
                    size: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
