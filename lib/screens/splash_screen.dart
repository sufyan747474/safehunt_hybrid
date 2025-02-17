import 'dart:async';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/screens/drawer/main_screen.dart';
import 'package:safe_hunt/utils/app_navigation.dart';
import 'package:safe_hunt/utils/services/firebase_messaging_service.dart';
import 'package:safe_hunt/utils/services/shared_preference.dart';

import 'app_main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static int splashDuration = 3;

  //sharepreference
  initSharedPreference() async {
    await SharedPreference().sharedPreference;
  }

  void _requestNotification() async {
    log('request Notification');
    await FirebaseMessagingService().initializeNotificationSettings();
    _setNotification();
  }

  void _setNotification() async {
    log('set Notification');

    FirebaseMessagingService().foregroundNotification();
    FirebaseMessagingService().backgroundTapNotification();
  }

  // fetch token
  void fetchToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      log('Firebase Messaging Token: $token');
    } catch (e) {
      log('Error fetching token: $e');
    }
  }

  Future<void> splashFunction() async {
    final user = SharedPreference().getUser();
    final accessToken = SharedPreference().getBearerToken();
    log("token :  ${accessToken.toString()}");
    if (user != null) {
      Logger().i('User Data');
      Logger().i(user.toJson());
      Logger().i(accessToken);
      await context.read<UserProvider>().setUser(user);

      // ignore: use_build_context_synchronously
      AppNavigation.pushAndRemoveUntil(const MainScreen());
    } else {
      AppNavigation.pushAndRemoveUntil(const AppMainScreen());
    }

    // navigation(null, false);
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    initSharedPreference();
    _requestNotification();
    fetchToken();
    Timer(Duration(seconds: splashDuration), () => splashFunction());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Image.asset(
          "assets/splash_screen.png",
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
