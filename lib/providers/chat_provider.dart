import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:safe_hunt/screens/model/chat_model.dart';

class ChatProvider extends ChangeNotifier {
  //! <----------------------------  single Chat data  -------------------------->
  List<ChatModel> _chatData = [];
  List<ChatModel> get chatData => _chatData;
  bool? hasChatData;
  setChat(List<ChatModel> chatData) {
    if (chatData.isNotEmpty) {
      hasChatData = true;
      _chatData = chatData;
    } else {
      hasChatData = false;
    }
    log('length: ${_chatData.length}');
    notifyListeners();
  }

  // updateChatData({int? index, String? message, String? date}) {
  //   if (index != null) {
  //     _singleInboxList[index].message = message;
  //     _singleInboxList[index].updatedAt = date;
  //     notifyListeners();
  //   }
  // }

  addChatInList(ChatModel? chatData) {
    _chatData.add(chatData ?? ChatModel());
    hasChatData = true;
    notifyListeners();
  }

  emptyChat() {
    hasChatData = null;
    _chatData = [];
    notifyListeners();
  }

  //! <----------------------------  Group Chat data  -------------------------->
  // List<GroupChatData> _groupChatData = [];
  // List<GroupChatData>? get groupChatData => _groupChatData;
  // bool? hasGroupChat;

  // setGroupChatData(List<GroupChatData>? groupChatData) {
  //   if (groupChatData != null && groupChatData.isNotEmpty) {
  //     _groupChatData = groupChatData;
  //     hasGroupChat = true;
  //     log('hasGroupChatData : $hasGroupChat');
  //   } else {
  //     hasGroupChat = false;
  //     log('hasGroubChatData : $hasGroupChat');
  //   }
  //   notifyListeners();
  // }

  // addChatInGroupChat(GroupChatData? groupChat) {
  //   _groupChatData.add(groupChat!);
  //   hasGroupChat = true;
  //   notifyListeners();
  // }

  // emptyGroupChatData() {
  //   _groupChatData = [];
  //   hasGroupChat = null;
  //   notifyListeners();
  // }

  //get the duration if the aduio
  // Duration? audioDuration;
  // Future<void> _getAudioDuration() async {
  //   final player = AudioPlayer(); // Initialize the audio player

  //   try {
  //     final audioSrc = NetworkStrings.IMAGE_BASE_URL +
  //         (groupChatData[0]. widget.chatData.file != null ? widget.chatData.file![0] : "");

  //     await player.setUrl(audioSrc); // Set the audio URL
  //     audioDuration = await player.durationFuture; // Get the duration

  //     if (mounted) {
  //       setState(() {}); // Update the state once the duration is fetched
  //     }
  //   } catch (e) {
  //     log("Error fetching audio duration: $e");
  //   } finally {
  //     player.dispose(); // Dispose of the player after getting the duration
  //   }
  // }

  //! <---------- get chat Inbox -------------->

  // List<InboxModel> _inboxList = [];
  // List<InboxModel> get inboxList => _inboxList;
  // bool? hasInboxList;
  // setInboxList(List<InboxModel> inbox) {
  //   if (inbox.isNotEmpty) {
  //     _inboxList = inbox;
  //     hasInboxList = true;
  //   } else {
  //     hasInboxList = false;
  //     _inboxList = [];
  //   }
  //   notifyListeners();
  // }

  // updateNewMwssageCount(String id) {
  //   final index = _inboxList.indexWhere((element) => element.id == id);

  //   if (index != -1) {
  //     _inboxList[index].newMsgCount = '0';
  //     notifyListeners();
  //   }
  // }

  // emptyInboxList() {
  //   _inboxList = [];
  //   hasInboxList = null;
  //   notifyListeners();
  // }

  //! <---------- filter chat Inbox -------------->

  // List<InboxModel> _filterInboxList = [];
  // List<InboxModel> get filterInboxList => _filterInboxList;
  // bool? hasFilterInboxList;
  // setFilterInboxList({required String title}) {
  //   if (title.isNotEmpty) {
  //     final searchList = _inboxList.where((element) =>
  //         '${element.senderFirstName} ${element.senderLastName}'
  //             .toLowerCase()
  //             .contains(title.toLowerCase()));

  //     _filterInboxList = searchList.toList();
  //     if (_filterInboxList.isEmpty) {
  //       hasFilterInboxList = false;
  //     } else {
  //       hasFilterInboxList = true;
  //     }
  //     log('Inbox length : ${_filterInboxList.length}');
  //     notifyListeners();
  //   } else {
  //     hasFilterInboxList = null;
  //     _filterInboxList = [];
  //     log('Inbox length : ${_filterInboxList.length}');
  //     notifyListeners();
  //   }
  // }

  // emptyFilterInboxList() {
  //   hasFilterInboxList = null;
  //   _filterInboxList = [];
  //   notifyListeners();
  // }

  // removeChatFromInboxList(String id) {
  //   final index =
  //       _singleInboxList.indexWhere((element) => element.groupId == groupId);

  //   if (index != -1) {
  //     _singleInboxList.removeAt(index);
  //     if (_singleInboxList.isEmpty) {
  //       hasSingleInboxList = false;
  //     }
  //     notifyListeners();
  //   }
  // }

  // void pinChatFromList(String groupId) {
  //   final index =
  //       _singleInboxList.indexWhere((element) => element.groupId == groupId);

  //   if (index != -1) {
  //     final chatItem = _singleInboxList.removeAt(index);
  //     _singleInboxList.insert(0, chatItem);
  //     notifyListeners();
  //   }
  // }

  //! <------------------- get group chat inbox --------------->

  // List<GroupChatList> _groupInboxList = [];
  // List<GroupChatList> get groupInboxList => _groupInboxList;
  // bool? hasGroupInboxList;
  // setGroupInboxList({required List<GroupChatList> inbox}) {
  //   if (inbox.isNotEmpty) {
  //     _groupInboxList = inbox;
  //     hasGroupInboxList = true;
  //   } else {
  //     hasGroupInboxList = false;
  //   }
  //   notifyListeners();
  // }

  // removeGroupFromList(String groupId) {
  //   final index =
  //       _groupInboxList.indexWhere((element) => element.id == groupId);
  //   if (index != -1) {
  //     _groupInboxList.removeAt(index);
  //     if (_groupInboxList.isEmpty) {
  //       hasGroupInboxList = false;
  //     }
  //     notifyListeners();
  //   }
  // }

  // emptyGroupInboxList() {
  //   _groupInboxList = [];
  //   hasGroupInboxList = null;
  //   notifyListeners();
  // }

//! <--------------------- gel all group Member --------------->

  // List<GroupMemberList> _groupMemberList = [];
  // List<GroupMemberList> get groupMemberList => _groupMemberList;

  // bool? hasGroupMemberList;
  // setGroupMemberList({List<GroupMemberList>? groupMemberList}) {
  //   if (groupMemberList != null && groupMemberList.isNotEmpty) {
  //     _groupMemberList = groupMemberList;
  //     hasGroupMemberList = true;
  //   } else {
  //     hasGroupMemberList = false;
  //   }
  //   notifyListeners();
  // }

  // addGroupMemberInList(
  //     {String? memberId, String? memberName, String? memberImage}) {
  //   final index =
  //       _groupMemberList.indexWhere((element) => element.id == memberId);
  //   if (index == -1) {
  //     _groupMemberList.add(GroupMemberList(
  //         id: memberId, firstname: memberName, image: memberImage));
  //     log("group member Length ${_groupMemberList.length}");
  //     notifyListeners();
  //   }
  // }

  // removeGroupMemberFromList(String memberId) {
  //   final index =
  //       _groupMemberList.indexWhere((element) => element.id == memberId);
  //   if (index != -1) {
  //     _groupMemberList.removeAt(index);
  //     if (_groupMemberList.isEmpty) {
  //       hasGroupMemberList = false;
  //     }
  //     log("group member Length ${_groupMemberList.length}");

  //     notifyListeners();
  //   }
  // }

  //! <---------- filter group member -------------->

  // List<GroupMemberList> _filterGroupMemberList = [];
  // List<GroupMemberList> get filterGroupMemberList => _filterGroupMemberList;
  // bool? hasFilterGroupMemberList;
  // setFilterGroupMemberList({required String title}) {
  //   if (title.isNotEmpty) {
  //     final searchList = _groupMemberList.where((element) =>
  //         element.firstname!.toLowerCase().contains(title.toLowerCase()));

  //     _filterGroupMemberList = searchList.toList();
  //     if (_filterGroupMemberList.isEmpty) {
  //       hasFilterGroupMemberList = false;
  //     } else {
  //       hasFilterGroupMemberList = true;
  //     }
  //     log('Group Member length : ${_filterGroupMemberList.length}');
  //     notifyListeners();
  //   } else {
  //     hasFilterGroupMemberList = null;
  //     _filterGroupMemberList = [];
  //     log('Group Member length : ${_filterGroupMemberList.length}');
  //     notifyListeners();
  //   }
  // }

  // emptyGroupMemberList({bool notifyListner = true}) {
  //   _groupMemberList = [];
  //   hasGroupMemberList = null;
  //   hasFilterGroupMemberList = null;
  //   _filterGroupMemberList = [];
  //   notifyListner ? notifyListeners() : null;
  // }

  //! <---------- filter group chat Inbox -------------->

  // List<GroupChatList> _filterGroupInboxList = [];
  // List<GroupChatList> get filterGroupInboxList => _filterGroupInboxList;
  // bool? hasFilterGroupInboxList;
  // setFilterGroupInboxList({required String title}) {
  //   if (title.isNotEmpty) {
  //     final searchList = _groupInboxList.where((element) =>
  //         element.description!.toLowerCase().contains(title.toLowerCase()));

  //     _filterGroupInboxList = searchList.toList();
  //     if (_filterGroupInboxList.isEmpty) {
  //       hasFilterGroupInboxList = false;
  //     } else {
  //       hasFilterGroupInboxList = true;
  //     }
  //     log('Group Inbox length : ${_filterGroupInboxList.length}');
  //     notifyListeners();
  //   } else {
  //     hasFilterGroupInboxList = null;
  //     _filterGroupInboxList = [];
  //     log('Group Inbox length : ${_filterGroupInboxList.length}');
  //     notifyListeners();
  //   }
  // }

  // emptyFilterGroupInboxList() {
  //   hasFilterGroupInboxList = null;
  //   _filterGroupInboxList = [];
  //   notifyListeners();
  // }

  //! <---------- Clear chat Inbox -------------->

  clearChatProvider() {
    _chatData = [];
    hasChatData = null;
    // _groupChatData = [];
    // hasGroupChat = null;
    // _inboxList = [];
    // hasInboxList = null;
    // _groupInboxList = [];
    // hasGroupInboxList = null;
    // _groupMemberList = [];
    // hasGroupMemberList = null;
    // _filterInboxList = [];
    // hasFilterInboxList = null;
    notifyListeners();
  }
}
