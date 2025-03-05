import 'dart:developer';
import 'package:safe_hunt/utils/common/network_strings.dart';
import 'package:safe_hunt/utils/services/socket_service/socket_navigation.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketService {
  static Socket? _socket;
  static SocketService? _instance;
  SocketService._();
  static SocketService? get instance {
    _instance ??= SocketService._();
    return _instance;
  }

  Socket? get socket => _socket;
  void initializeSocket({bool? fromChatSocket}) {
    _socket = io(
      NetworkStrings.SOCKET_URL,
      <String, dynamic>{
        'autoConnect': false,
        'transports': ['websocket'],
      },
    );
  }

  void connectSocket() {
    _socket?.connect();
    _socket?.on('connect', (_) => log('Socket connected'));
    _socket!.on('reconnect', (attempt) {
      log("Socket Reconnected: Attempt $attempt");
      // _joinChat(chatId: chatId);
      // _getMessages(chatId: chatId, type: type);
    });
    _socket?.on('disconnect', (data) => log('Socket disconnected: $data'));
    _socket?.on('connect_error', (data) => log('Connection error: $data'));
    _socket?.on('error', (data) {
      log('Socket error');
      SocketNavigationClass.instance.socketErrorMethod(errorResponseData: data);
    });
  }

  void emitEvent({
    required String eventName,
    required dynamic eventParamaters,
  }) {
    log('Event Name : $eventName');
    log('Event parameter : $eventParamaters');
    _socket?.emit(
      eventName,
      eventParamaters,
    );
  }

  void listen(String event, Function(dynamic data) callback) {
    _socket?.on(event, callback);
  }

  static Future<void> commonConnectSocket() async {
    log("Connecting to socket...");
    instance?.initializeSocket();
    instance?.connectSocket();
    instance?._setupListeners();
  }

  void dispose() {
    _socket?.dispose();
  }

  void _setupListeners() {
    listen(
        'response',
        (data) => SocketNavigationClass.instance
            .socketResponseMethod(responseData: data));
  }
}
