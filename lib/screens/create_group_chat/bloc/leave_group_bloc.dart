// import 'package:ananamustalk/modules/chat/provider/chat_provider.dart';
// import 'package:ananamustalk/utils/app_navigation.dart';
// import 'package:ananamustalk/utils/constant/network_strings.dart';
// import 'package:ananamustalk/utils/services/network/network.dart';
// import 'package:ananamustalk/utils/tost.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class LeaveGroupBloc {
//   dynamic _formData;
//   Response? _response;
//   VoidCallback? _onSuccess, _onFailure;
//   String? _groupId;

//   void leaveGroupBlocMethod({
//     required BuildContext context,
//     required VoidCallback setProgressBar,
//     String? groupId,
//   }) async {
//     setProgressBar();
//     _groupId = groupId;

//     _formData = {
//       "_id": groupId,
//     };

//     /// Form Data
//     // Logger().i(albumVideos?.length);
//     print(_formData);

//     _onFailure = () {
//       Navigator.pop(context);
//     };

//     // ignore: use_build_context_synchronously
//     await _postRequest(
//         endPoint: NetworkStrings.LEAVE_GROUP_ENDPOINT, context: context);

//     _onSuccess = () {
//       Navigator.pop(context);
//       _leaveGroupResponseMethod(context: context);
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

//   void _leaveGroupResponseMethod({required BuildContext context}) async {
//     try {
//       if (_response?.data != null) {
//         if (_response?.data['status'] == 1) {
//           AppNavigator.pop(context);
//           AppNavigator.pop(context);
//           context.read<ChatProvider>().removeGroupFromList(_groupId!);
//         }
//       }
//     } catch (error) {
//       showToastMessage(msg: NetworkStrings.SOMETHING_WENT_WRONG);
//     }
//   }
// }
