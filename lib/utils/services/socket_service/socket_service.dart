// import 'dart:convert';
// import 'dart:developer';
// import 'package:logger/logger.dart';

// import 'package:socket_io_client/socket_io_client.dart';


// class SocketService {
//   static Socket? _socket;

//   SocketService._();

//   static SocketService? _instance;

//   static SocketService? get instance {
//     _instance ??= SocketService._();
//     return _instance;
//   }

//   Socket? get socket => _socket;

//   void initializeSocket() {
//     _socket = io("https://server1.appsstaging.com:3100", <String, dynamic>{
//       'autoConnect': false,
//       'transports': ['websocket'],
//     });
//   }

//   void connectSocket(context) {
//     _socket?.connect();

//     _socket?.on("connect", (data) {
//       log('Connected socket');
//     });

//     _socket?.on("disconnect", (data) {
//       log('Disconnected ' + data.toString());
//     });

//     _socket?.on("connect_error", (data) {
//       log('Connect Error ' + data.toString());
//     });

//     _socket?.on("error", (data) {
//       log('Error ' + data.toString());
//     });
//   }

//   void socketEmitMethod(
//       {required String eventName, required dynamic eventParamaters}) {
//     Logger().i('Event Name : $eventName');
//     Logger().i('Event parameter : $eventParamaters');

//     _socket?.emit(
//       eventName,
//       eventParamaters,
//     );
//   }

//   void socketResponseMethod(context) {
//     _socket?.on("response", (data) {
//       log("socket!.on function chal rha hai");
//       log(jsonEncode(data));

//       var chatPro = ChatController.i;
//       var userController = AuthController.i;
//       // var chatPro = Provider.of<ChatProvider>(
//       //     AppNavigator.navigatorKey.currentContext!,
//       //     listen: false);

//       // var userProvider = Provider.of<UserProvider>(
//       //     AppNavigator.navigatorKey.currentContext!,
//       //     listen: false);

//       // if (data["object_type"] == "get_messages") {
//       //   log("handle get message response");
//       //   chatPro.setChatData(ChatModel.fromJson(data));
//       // } else if (data["object_type"] == "get_message") {
//       //   log("handle send message response");

//       //   ChatData chatMsge = ChatModel.fromJson(data).data!.first;

//       //   // ChatData.fromJson(data['data']);
//       //   if ((userProvider.userData?.id.toString() ==
//       //               chatMsge.senderId.toString() ||
//       //           userProvider.userData?.id.toString() ==
//       //               chatMsge.receiverId.toString()) &&
//       //       (userProvider.otherUserId == chatMsge.senderId.toString() ||
//       //           userProvider.otherUserId == chatMsge.receiverId?.toString())) {
//       //     chatPro.setSingleChat(chatMsge);
//       //   }
//       // }

//       if (data["object_type"] == "get_comments") {
//         log("handle get comments response");
//         final streamData = StreamCommentModel.fromJson(data);
//         chatPro.setStreamCommentList(streamComments: streamData.data?.comments);
//       } else if (data["object_type"] == "send_comment") {
//         log("handle get comment response");

//         StreamComment streamComment =
//             StreamComment.fromJson(data['data']['comment']);

//         chatPro.setSingleStreamComment(streamComment);
//       }
//     });
//   }

//   void dispose() {
//     _socket?.dispose();
//   }
// }
