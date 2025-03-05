import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/static_data.dart';

class SocketNavigationClass {
  static final SocketNavigationClass instance =
      SocketNavigationClass._internal();
  factory SocketNavigationClass() => instance;
  SocketNavigationClass._internal();
  void socketResponseMethod({required dynamic responseData}) {
    if (responseData == null) return;
    log('Response Data: $responseData');
    // log('Current Route: ${Get.currentRoute}');
    _handleChatResponse(responseData);
  }

  final userProvider =
      StaticData.navigatorKey.currentState?.context.read<UserProvider>();
  // String currentUser = userProvider.userProvider
  // .user.id,

  void _handleChatResponse(dynamic responseData) {
    switch (responseData['object_type']) {
      // <--------------------------------- chat navigation -------------------------->
      case NetworkStrings.GET_MESSAGES_KEY:
        // final chat = List<ChatData>.from(
        //     responseData['data']?.map((x) => ChatData.fromJson(x))).toList();
        // navigatorKey.currentState!.context
        //     .read<ChatProvider>()
        //     .setChatData(chat);
        break;

      case NetworkStrings.GET_MESSAGE_KEY:
        // final chat = ChatData.fromJson(responseData['data']);
        // navigatorKey.currentState!.context
        //     .read<ChatProvider>()
        //     .setSingleChat(chat);
        break;

      default:
        log('Unknown Chat Response Type');
        break;
    }
  }

  void socketErrorMethod({dynamic errorResponseData}) {
    if (errorResponseData == null) return;
    switch (errorResponseData['objectType']) {
      default:
        log('Unknown Error Response Type');
        break;
    }
  }
}
