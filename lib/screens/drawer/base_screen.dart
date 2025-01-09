import 'package:flutter/material.dart';
import 'package:safe_hunt/screens/drawer/main_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({
    Key? key,
  }) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // backgroundColor: Colors.transparent,
      extendBody: true,
      body: Stack(
        children: [
          // DrawerScreen(),
          MainScreen(),
        ],
      ),
    );
  }
}
