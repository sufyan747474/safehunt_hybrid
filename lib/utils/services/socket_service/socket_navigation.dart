import 'dart:developer';
import 'package:provider/provider.dart';
import 'package:safe_hunt/providers/chat_provider.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/screens/model/chat_model.dart';
import 'package:safe_hunt/utils/static_data.dart';

class SocketNavigationClass {
  static final SocketNavigationClass instance =
      SocketNavigationClass._internal();
  factory SocketNavigationClass() => instance;
  SocketNavigationClass._internal();
  void socketResponseMethod(
      {required dynamic responseData, bool isMessageReceived = false}) {
    if (responseData == null) return;
    log('Response Data: $responseData');
    log('is message received: $isMessageReceived');

    // log('Current Route: ${Get.currentRoute}');
    _handleChatResponse(responseData, isMessageReceived);
  }

  final userProvider =
      StaticData.navigatorKey.currentState?.context.read<UserProvider>();
  // String currentUser = userProvider.userProvider
  // .user.id,

  void _handleChatResponse(dynamic responseData, bool isMessageReceived) {
    switch (responseData) {
      // <--------------------------------- chat navigation -------------------------->
      case Map<String, dynamic> data when data.containsKey('messages'):
        final chat = List<ChatModel>.from(
                responseData['messages']?.map((x) => ChatModel.fromJson(x)))
            .toList();
        StaticData.navigatorKey.currentState!.context
            .read<ChatProvider>()
            .setChat(chat);
        break;

      default:
        if (isMessageReceived) {
          final chat = ChatModel.fromJson(responseData);
          chat.createdAt = DateTime.now().toString();

          StaticData.navigatorKey.currentState!.context
              .read<ChatProvider>()
              .addChatInList(chat);
        } else {
          log('Unknown Chat Response Type');
        }
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
