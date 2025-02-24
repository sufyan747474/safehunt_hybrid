import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe_hunt/screens/friend_module/widget/custom_tab_item_widget.dart';
import 'package:safe_hunt/utils/colors.dart';

class CustomTabWidget<T> extends StatelessWidget {
  const CustomTabWidget(
      {super.key,
      this.height,
      this.backgroundColor,
      this.borderRadius,
      this.selectedValue,
      required this.tabs,
      required this.onChange});

  final double? height;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final T? selectedValue;
  final List<CustomTabItemWidget<T>> tabs;
  final Function(T?) onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: height ?? 55.h,
      decoration: BoxDecoration(
          color: backgroundColor ?? appBrownColor.withOpacity(.6),
          borderRadius: borderRadius ?? BorderRadius.circular(12.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (int i = 0; i < tabs.length; i++)
            GestureDetector(
                onTap: () {
                  onChange.call(tabs[i].value);
                },
                child: getTabs(tabs[i]))
        ],
      ),
    );
  }

  Widget getTabs(CustomTabItemWidget<T> item) {
    final val = CustomTabItemWidget(
        value: item.value, selectedValue: selectedValue, title: item.title);
    return val;
  }
}
