// import 'dart:developer';

// import 'package:adaashi/utils/network_strings.dart';
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

// class DynamicLinkProvider {
//   ///Create Link
//   Future<String> createLink({String? productId}) async {
//     // final String url =
//     //     "${AppConstant.DYNAMIC_URL}?${AppStrings.POST_ID}=$postId&${AppStrings.POST_INDEX}=$postIndex";
//     const String url = NetworkStrings.DYNAMIC_URL
//         // ?${AppConstant.ProductId}=$productId

//         ;
//     // const String url = AppConstant.DYNAMIC_URL;
//     final DynamicLinkParameters parameters = DynamicLinkParameters(
//         androidParameters: const AndroidParameters(
//             packageName: NetworkStrings.APP_PACKAGE_NAME,
//             minimumVersion: NetworkStrings.ANDROID_MINIMUM_VERSION),
//         iosParameters: const IOSParameters(
//           bundleId: NetworkStrings.APP_BUNDLE_ID,
//           minimumVersion: NetworkStrings.IOS_MINIMUM_VERSION,
//           appStoreId: NetworkStrings.APP_STORE_ID,
//         ),
//         link: Uri.parse(url),
//         uriPrefix: NetworkStrings.DYNAMIC_URL);
//     final FirebaseDynamicLinks link = await FirebaseDynamicLinks.instance;
//     final refLink = await link.buildShortLink(parameters);
//     return refLink.shortUrl.toString();
//   }

//   /// Initialize dynamic link
//   FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

//   Future<void> initDynamicLinks() async {
//     log('Dynamic linking is intialize');

//     ///this will call when app is in foreground
//     dynamicLinks.onLink.listen(
//       (dynamicLinkData) {
//         // AppDialogs.showToast(message: "from forgound state");
//         // Listen and retrieve dynamic links here
//         final String deepLink =
//             dynamicLinkData.link.toString(); // Get DEEP LINK

//         log('deepLink : ${deepLink}');

//         // Ex: product/013232
//         if (deepLink.isEmpty) return;
//         handleDeepLink(queryParam: dynamicLinkData.link.queryParameters);
//       },
//     ).onError(
//       (error) {
//         print('onLink error');
//         print(error.message);
//       },
//     );

//     ///this will call when app is in killed state
//     initUniLinks();
//   }

//   Future<void> initUniLinks() async {
//     try {
//       final initialLink = await dynamicLinks.getInitialLink();
//       if (initialLink == null) return;
//       handleDeepLink(queryParam: initialLink.link.queryParameters);
//     } catch (e) {
//       print("error is " + e.toString());
//     }
//   }

//   void handleDeepLink({Map<String, dynamic>? queryParam}) async {
//     //   log('product id :  ${queryParam![AppConstant.ProductId]}');
//     //   if (queryParam != null) {
//     //     if (SharedPreference().getUser() != null) {
//     //       AppNavigator.navigatorKey.currentState?.context
//     //           .read<UserProvider>()
//     //           .setRoleType(AppNavigator.navigatorKey.currentState?.context
//     //                       .read<UserProvider>()
//     //                       .userData
//     //                       ?.role ==
//     //                   'User'
//     //               ? RoleType.user
//     //               : RoleType.provider);
//     //       if (AppConstant.currentRoute != '/productDetails') {
//     //         AppNavigator.navigatorKey.currentState?.context
//     //             .read<GerageProvider>()
//     //             .emptyProductDetails();
//     //         AppNavigator.pushNamed(
//     //           AppRoutes.productDetailRoute,
//     //           arguments: AddProductArguments(
//     //             productId: queryParam[AppConstant.ProductId].toString(),
//     //             iscomeFromDynamicLink: true,
//     //           ),
//     //         );
//     //       }

//     //     }
//     //   }
//   }
// }
