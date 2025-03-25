// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';

// import 'package:ananamustalk/modules/main_screen/zoom_drawer.dart';
// import 'package:ananamustalk/modules/post/provider/post_provider.dart';
// import 'package:ananamustalk/utils/app_navigation.dart';
// import 'package:ananamustalk/utils/constant/app_strings.dart';
// import 'package:ananamustalk/utils/constant/network_strings.dart';
// import 'package:ananamustalk/utils/popups/success_popup.dart';
// import 'package:ananamustalk/utils/services/network/network.dart';
// import 'package:ananamustalk/utils/tost.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';
// import 'package:provider/provider.dart';

// class EditGroupChatBloc {
//   FormData? _formData;
//   Response? _response;
//   VoidCallback? _onSuccess, _onFailure;
//   Map<String, dynamic> userObject = {};

//   void editGroupChatBlocMethod({
//     required BuildContext context,
//     required VoidCallback setProgressBar,
//     String? description,
//     String? groupImage,
//     String? groupId,
//   }) async {
//     setProgressBar();
//     File groupImageFile = File(groupImage ?? "");
//     String groupImagePath = groupImageFile.path;
//     Logger().i("imagePAth : $groupImagePath");

//     userObject = {
//       "id": groupId,
//       "members": jsonEncode(context.read<PostProvider>().selectedTagPeople),
//       "description": description,
//     };
//     Logger().i("create group chat Data");
//     log(userObject.toString());
//     if (groupImage != null) {
//       userObject["groupImages"] = await MultipartFile.fromFile(groupImage);
//     }

//     _formData = FormData.fromMap(userObject);

//     _onFailure = () {
//       Navigator.pop(context);
//     };

//     // ignore: use_build_context_synchronously
//     await _postRequest(
//         endPoint: NetworkStrings.EDIT_GROUP_CHAT_ENDPOINT, context: context);

//     _onSuccess = () {
//       Navigator.pop(context);
//       _editGroupChatResponseMethod(context: context);
//     };
//     _validateResponse();
//   }

//   ///----------------------------------- Post Request -----------------------------------
//   Future<void> _postRequest(
//       {required String endPoint, required BuildContext context}) async {
//     _response = await Network().postRequest(
//       baseUrl: NetworkStrings.API_BASE_URL,
//       endPoint: endPoint,
//       formData: _formData,
//       context: context,
//       onFailure: _onFailure,
//       isHeaderRequire: true,
//     );
//   }

//   ///----------------------------------- Validate Response -----------------------------------
//   void _validateResponse() {
//     if (_response != null) {
//       Network().validateResponse(
//           response: _response,
//           onSuccess: _onSuccess,
//           onFailure: _onFailure,
//           isToast: false);
//     }
//   }

//   void _editGroupChatResponseMethod({required BuildContext context}) async {
//     try {
//       if (_response?.data != null) {
//         if (_response?.data['status'] == 1) {
//           showSuccessDialog(
//             context: context,
//             title: AppStrings.successfullyUpdated,
//             description: 'Group has been updated successfully.',
//             buttonText: AppStrings.continuE,
//             onTap: () {
//               AppNavigator.pushAndRemoveUntil(context, const MyZoomDrawer());
//             },
//             canPop: false,
//           );
//         }
//       }
//     } catch (error) {
//       showToastMessage(msg: NetworkStrings.SOMETHING_WENT_WRONG);
//     }
//   }
// }
