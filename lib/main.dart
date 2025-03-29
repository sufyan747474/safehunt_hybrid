import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/providers/chat_provider.dart';
import 'package:safe_hunt/providers/post_provider.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/screens/splash_screen.dart';
import 'package:safe_hunt/utils/static_data.dart';
import 'binding/app_binding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(MultiProvider(providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PostProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatProvider(),
        )
      ], child: const MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) {
          return GetMaterialApp(
            navigatorKey: StaticData.navigatorKey,
            initialRoute: "/",
            initialBinding: AppBinding(),
            getPages: [
              GetPage(name: "/", page: () => const SplashScreen()), // here!
            ],
            theme: ThemeData(
                textTheme: GoogleFonts.montserratTextTheme(
              Theme.of(context).textTheme,
            )),
            title: 'Safe Hunt',
            debugShowCheckedModeBanner: false,
            // home: SplashScreen(),
          );
        });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
