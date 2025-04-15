import 'dart:convert';
import 'dart:developer';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:safe_hunt/model/user_model.dart';
import 'package:safe_hunt/providers/chat_provider.dart';
import 'package:safe_hunt/providers/user_provider.dart';
import 'package:safe_hunt/screens/model/chat_model.dart';
import 'package:safe_hunt/utils/colors.dart';
import 'package:safe_hunt/utils/common/app_colors.dart';
import 'package:safe_hunt/utils/services/socket_service/socket_service.dart';
import 'package:safe_hunt/utils/utils.dart';
import 'package:safe_hunt/widgets/Custom_image_widget.dart';
import 'package:path/path.dart' as p;

import '../../widgets/big_text.dart';
import '../../widgets/user_message_card.dart';
import 'package:flutter/foundation.dart' as foundation;

class UserChat extends StatefulWidget {
  final String receiverId;
  final String receiverName;
  final String? receiverImage;

  const UserChat(
      {super.key,
      required this.receiverId,
      required this.receiverName,
      this.receiverImage});

  @override
  State<UserChat> createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  final TextEditingController _messageController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isEmojiPickerVisible = false;
  UserData? user;

  @override
  void initState() {
    user = context.read<UserProvider>().user;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<ChatProvider>().clearChatProvider();
      await SocketService.commonConnectSocket(
          receiverUserId: widget.receiverId);
      SocketService.instance?.emitEvent(
        eventName: "getAllMessages",
        eventParamaters: {
          "event": "allMessages",
          "data": {"receiverUserId": widget.receiverId}
        },
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    SocketService.instance?.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _toggleEmojiKeyboard() {
    if (_isEmojiPickerVisible) {
      _focusNode.requestFocus();
    } else {
      _focusNode.unfocus();
    }
    setState(() {
      _isEmojiPickerVisible = !_isEmojiPickerVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, val, _) {
      return Scaffold(
        backgroundColor: subscriptionCardColor,
        appBar: AppBar(
          backgroundColor: appButtonColor,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 23.sp),
            onPressed: () => Get.back(),
          ),
          titleSpacing: -3,
          title: Row(
            children: [
              CustomImageWidget(
                imageUrl: widget.receiverImage,
                imageHeight: 40.w,
                imageWidth: 40.w,
                borderColor: AppColors.greenColor,
                borderWidth: 2.r,
              ),
              SizedBox(width: 8.w),
              BigText(
                text: widget.receiverName,
                size: 16.sp,
                fontWeight: FontWeight.w700,
                color: appBlackColor,
              ),
            ],
          ),
        ),
        body: val.hasChatData == null
            ? const Center(
                child: CircularProgressIndicator(
                color: appLightGreenColor,
                backgroundColor: appRedColor,
              ))
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      shrinkWrap: true,
                      itemCount: val.chatData.length,
                      itemBuilder: (context, index) {
                        final chat =
                            val.chatData[val.chatData.length - 1 - index];
                        return UserChatCard(
                          reveiverImage: widget.receiverImage,
                          attachment: chat.attachment,
                          isMe: chat.senderId == user?.id,
                          message: chat.message ?? "",
                          userName: chat.senderId == user?.id
                              ? user?.displayname ?? ""
                              : widget.receiverName,
                          chatTime: chat.createdAt ?? '',
                        );
                      },
                    ),
                  ),

                  // Input Area
                  Container(
                    color: appButtonColor,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Emoji Button
                            IconButton(
                              icon: const Icon(Icons.emoji_emotions_outlined),
                              onPressed: _toggleEmojiKeyboard,
                            ),

                            SizedBox(width: 5.w),

                            // Message Input
                            Expanded(
                              child: TextField(
                                controller: _messageController,
                                focusNode: _focusNode,
                                style: TextStyle(
                                    fontSize: 16.sp, color: appBrownColor),
                                maxLines: 5,
                                minLines: 1,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.zero,
                                  hintText: 'Write a message.......',
                                  hintStyle: TextStyle(
                                      fontSize: 12.sp, color: appBrownColor),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(width: 10.w),

                            // Attachment Button
                            IconButton(
                              icon: Image.asset('assets/paper_clip.png'),
                              onPressed: () async {
                                Utils.unFocusKeyboard(context);
                                Utils.showImageSourceSheet(
                                  context: context,
                                  setFile: (file) async {
                                    log(file.path);

                                    // Determine MIME type
                                    String extension =
                                        p.extension(file.path).toLowerCase();
                                    String mimeType = extension == '.png'
                                        ? 'image/png'
                                        : 'image/jpeg';

                                    // Read and encode image
                                    List<int> imageBytes =
                                        await file.readAsBytes();
                                    String base64Image =
                                        "data:$mimeType;base64,${base64Encode(imageBytes)}";

                                    // Send via socket
                                    SocketService.instance?.emitEvent(
                                      eventName: "sendMessage",
                                      eventParamaters: {
                                        "receiverUserId": widget.receiverId,
                                        "attachment": base64Image,
                                        "messageType": "image",
                                        "message": '',
                                      },
                                    );

                                    // Add to chat list
                                    val.addChatInList(ChatModel(
                                      senderId: user?.id,
                                      receiverId: widget.receiverId,
                                      message: null,
                                      createdAt: DateTime.now().toString(),
                                      attachment: base64Image,
                                    ));
                                  },
                                );
                              },
                            ),

                            // Send Button
                            IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: () {
                                if (_messageController.text.trim().isNotEmpty) {
                                  SocketService.instance?.emitEvent(
                                    eventName: 'sendMessage',
                                    eventParamaters: {
                                      "receiverUserId": widget.receiverId,
                                      "message": _messageController.text,
                                      "messageType": "text",
                                    },
                                  );

                                  val.addChatInList(ChatModel(
                                    senderId: user?.id,
                                    receiverId: widget.receiverId,
                                    message: _messageController.text,
                                    createdAt: DateTime.now().toString(),
                                    attachment: null,
                                  ));

                                  _messageController.clear();
                                }
                              },
                            ),
                          ],
                        ),

                        // Emoji Picker
                        if (_isEmojiPickerVisible)
                          SizedBox(
                              height: 250,
                              child: EmojiPicker(
                                onEmojiSelected: (category, emoji) {
                                  log(emoji.emoji);

                                  _messageController.text += emoji.emoji;
                                },
                                onBackspacePressed: () {
                                  // Handle backspace if needed
                                },
                                // textEditingController: _messageController,
                                config: Config(
                                  height: 256,

                                  checkPlatformCompatibility: true,
                                  emojiViewConfig: EmojiViewConfig(
                                    backgroundColor: subscriptionCardColor,
                                    emojiSizeMax: 28 *
                                        (foundation.defaultTargetPlatform ==
                                                TargetPlatform.iOS
                                            ? 1.20
                                            : 1.0),
                                  ),
                                  swapCategoryAndBottomBar: false,
                                  skinToneConfig: const SkinToneConfig(),
                                  categoryViewConfig: const CategoryViewConfig(
                                      backgroundColor: subscriptionCardColor),
                                  bottomActionBarConfig:
                                      const BottomActionBarConfig(
                                          showBackspaceButton: false,
                                          showSearchViewButton: false),
                                  // Remove the search view by setting it to null
                                ),
                              )),
                      ],
                    ),
                  ),
                ],
              ),
      );
    });
  }
}
