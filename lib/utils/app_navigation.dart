import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:safe_hunt/utils/static_data.dart';

class AppNavigation {
  static BuildContext? get context =>
      StaticData.navigatorKey.currentState?.context;

  /// Helper method to build routes
  static CupertinoPageRoute<T> _buildRoute<T>(Widget widget) {
    return CupertinoPageRoute(
      builder: (context) => widget,
      fullscreenDialog: !Platform.isIOS,
    );
  }

  ///-------------------- Normal Routes -------------------- ///
  static void push(Widget widget) {
    if (context == null) {
      debugPrint("Navigation context is null. Navigation aborted.");
      return;
    }
    Navigator.push(context!, _buildRoute(widget));
  }

  static void pushReplacement(Widget widget) {
    if (context == null) {
      debugPrint("Navigation context is null. Navigation aborted.");
      return;
    }
    Navigator.pushReplacement(context!, _buildRoute(widget));
  }

  static void pushAndRemoveUntil(Widget widget) {
    if (context == null) {
      debugPrint("Navigation context is null. Navigation aborted.");
      return;
    }
    Navigator.of(context!).pushAndRemoveUntil(
      _buildRoute(widget),
      (Route<dynamic> route) => false,
    );
  }

  static Future<dynamic> pushAndReturn(Widget widget) async {
    if (context == null) {
      debugPrint("Navigation context is null. Navigation aborted.");
      return null;
    }
    return await Navigator.push(context!, _buildRoute(widget));
  }

  ///-------------------- Named Routes -------------------- ///
  static void pushNamed(String route, [Object? arguments]) {
    if (context == null) {
      debugPrint("Navigation context is null. Navigation aborted.");
      return;
    }
    Navigator.pushNamed(context!, route, arguments: arguments);
  }

  static void pushReplacementNamed(String route, [Object? arguments]) {
    if (context == null) {
      debugPrint("Navigation context is null. Navigation aborted.");
      return;
    }
    Navigator.pushReplacementNamed(context!, route, arguments: arguments);
  }

  static void pushNamedAndRemoveUntil(String route, [Object? arguments]) {
    if (context == null) {
      debugPrint("Navigation context is null. Navigation aborted.");
      return;
    }
    Navigator.of(context!).pushNamedAndRemoveUntil(
      route,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  ///-------------------- Pop Operations -------------------- ///
  static void popWithData(dynamic data) {
    if (context == null) {
      debugPrint("Navigation context is null. Pop operation aborted.");
      return;
    }
    Navigator.of(context!).maybePop(data);
  }

  static void popUntil(String route) {
    if (context == null) {
      debugPrint("Navigation context is null. Pop operation aborted.");
      return;
    }
    Navigator.of(context!).popUntil(ModalRoute.withName(route));
  }

  static void pop() {
    if (context == null) {
      debugPrint("Navigation context is null. Pop operation aborted.");
      return;
    }
    Navigator.of(context!).pop();
  }
}
