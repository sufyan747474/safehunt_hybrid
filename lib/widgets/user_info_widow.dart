import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safe_hunt/utils/colors.dart';
import 'package:safe_hunt/widgets/big_text.dart';
import 'package:safe_hunt/widgets/triangle_clipper.dart';
import '../model/user.dart';

class UserInfoWindow extends StatelessWidget {
  final UserInfo user;

  const UserInfoWindow({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [
                Colors.white,
                Color(0xffffe6cc),
              ],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                // padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    border: Border.all(color: Colors.green)),

                child: CircleAvatar(
                  backgroundImage: NetworkImage(user.profileImageUrl),
                ),
              ),
              SizedBox(width: 8.0.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigText(
                    text: user.name,
                    color: appBlackColor,
                    fontWeight: FontWeight.w700,
                    size: 20.sp,
                  ),
                  // Text(user.name,
                  //     style:
                  //         TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  BigText(
                    text: user.email,
                    color: appBlackColor,
                    fontWeight: FontWeight.w500,
                    size: 10.sp,
                  ),
                ],
              ),
              // SizedBox(width: 8.0.w),
              Spacer(),

              SvgPicture.asset(
                'assets/add_friend_green.svg',
                height: 17.h,
              ),
              Spacer(),
              SvgPicture.asset(
                'assets/message.svg',
                height: 18.h,
              ),
              Spacer(),
            ],
          ),
        ),
        ClipPath(
          clipper: TriangleClipper(),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Colors.white,
                  Color(0xffffe6cc),
                ],
                end: Alignment.center,
                begin: Alignment.center,
              ),
            ),
            // color: Colors.red,
            height: 10.h,
            width: 20.w,
          ),
        ),
      ],
    );
  }
}
