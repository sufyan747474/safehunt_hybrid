import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_hunt/screens/splash_screen.dart';
import 'package:safe_hunt/utils/static_data.dart';
import 'binding/app_binding.dart';

void main() {
  runApp(const MyApp());
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
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            // home: SplashScreen(),
          );
        });
  }
}
