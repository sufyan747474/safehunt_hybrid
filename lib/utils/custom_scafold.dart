import 'package:flutter/material.dart';

import 'colors.dart';
import 'gradient_background.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final AppBar? appBar;

  const CustomScaffold({
    super.key,
    required this.body,
    this.appBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      backgroundColor: appLightGreenColor,
      body: LayoutBuilder(builder: (context, constrains) {
        return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: gradiantBackground,
            child: body);
      }),
    );
  }
}

typedef CustomBuilder = Widget Function(
  BuildContext context,
  double x,
  double y,
);
