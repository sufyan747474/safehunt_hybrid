import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_hunt/widgets/big_text.dart';

import '../utils/colors.dart';
//
// class Choice {
//   const Choice({required this.title, required this.icon});
//   final String title;
//   final IconData icon;
// }
//
// const List<Choice> choices =  <Choice>[
//    Choice(title: 'Home', icon: Icons.home),
//    Choice(title: 'Contact', icon: Icons.contacts),
//    Choice(title: 'Map', icon: Icons.map),
//    Choice(title: 'Phone', icon: Icons.phone),
//    Choice(title: 'Camera', icon: Icons.camera_alt),
//    Choice(title: 'Setting', icon: Icons.settings),
//    Choice(title: 'Album', icon: Icons.photo_album),
//    Choice(title: 'WiFi', icon: Icons.wifi),
// ];

class UserFriendsList extends StatelessWidget {
  const UserFriendsList({super.key, required this.title, required this.image});
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: appButtonColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        // color: Colors.orange,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 5.0.h,
              ),
              BigText(
                text: title,
                size: 12.sp,
                maxLine: 2,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(
                height: 15.h,
              )
            ]));
    ;
  }
}
