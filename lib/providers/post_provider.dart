import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:safe_hunt/model/user_model.dart';
import 'package:safe_hunt/screens/create_group_chat/model/group_member_model.dart';
import 'package:safe_hunt/screens/create_group_chat/model/group_model.dart';
import 'package:safe_hunt/screens/post/model/post_model.dart';

class PostProvider extends ChangeNotifier {
  //! <---------------------------- Get All Tag People  -------------------------->

  List<UserData> _getTagPeople = [];
  List<UserData> get getTagPeople => _getTagPeople;
  bool? hasTagPeople;

  setTagPeople(List<UserData> getTagPeople) {
    if (getTagPeople.isNotEmpty) {
      hasTagPeople = true;
      _getTagPeople = getTagPeople;
      _getTagPeople = getTagPeople
        ..sort((a, b) =>
            DateTime.parse(b.createdAt ?? DateTime.now().toString()).compareTo(
                DateTime.parse(a.createdAt ?? DateTime.now().toString())));
    } else {
      hasTagPeople = false;
    }
    notifyListeners();
  }

  emptyTagPeople() {
    _getTagPeople = [];
    hasTagPeople = null;
    notifyListeners();
  }

  //! <----------------------------  Tag people (only show in ui)  -------------------------->

  List<UserData> _tagPeopleList = [];
  List<UserData> get tagPeopleList => _tagPeopleList;

  setTagPeopleList(List<UserData> tagPeopleList) {
    if (tagPeopleList.isNotEmpty) {
      _tagPeopleList = tagPeopleList;
    }
    //! notifyListeners();
  }

  addTagPeopleList(UserData tagPeople) {
    if (!_tagPeopleList.any((element) => element.id == tagPeople.id)) {
      _tagPeopleList.add(tagPeople);
      notifyListeners();
      log('tag people length : ${_tagPeopleList.length}');
    }
  }

  removeTagPeopleList(UserData tagPeople) {
    _tagPeopleList.removeWhere((element) => element.id == tagPeople.id);

    notifyListeners();
  }

  emptyTagPeopleList() {
    _tagPeopleList = [];
  }

  //! <---------------------------- Get Selected Tag People Id  -------------------------->

  List<String> _selectedTagpeople = [];
  List<String> get selectedTagPeople => _selectedTagpeople;

  setTagPeopleId({required String id, bool isNotifyListner = true}) {
    if (_selectedTagpeople.contains(id)) {
      log('Tag People Length ${_selectedTagpeople.length}');
      isNotifyListner ? notifyListeners() : null;
    } else {
      _selectedTagpeople.add(id);
      log('Tag People Length ${_selectedTagpeople.length}');
      isNotifyListner ? notifyListeners() : null;
    }
    log('Tag People id ${id}');
  }

  removeTagPeopleId(String id) {
    _selectedTagpeople.removeWhere((element) => element == id);
    _tagPeopleList.removeWhere((element) => element.id == id);

    log('Tag People Length ${_selectedTagpeople.length}');
    notifyListeners();
  }

  emptySelectedTagPeople({bool isNotifyListner = true}) {
    _selectedTagpeople = [];
    log('Tag People Length ${_selectedTagpeople.length}');
    isNotifyListner ? notifyListeners() : null;
  }

  //! <--------------------- get user post with Id --------------->

  List<PostData> _userPost = [];
  List<PostData> get userpost => _userPost;
  bool? isUserPost;

  setUserPosts(List<PostData> post) {
    _userPost.addAll(post);

    if (_userPost.isNotEmpty) {
      isUserPost = true;
    } else if (_userPost.isEmpty) {
      isUserPost = false;
    }
    notifyListeners();
  }

  emptyUserPost() {
    _userPost = [];
    isUserPost = null;
    notifyListeners();
  }

  //! <--------------------- get all post --------------->

  List<PostData> _post = [];
  List<PostData> get post => _post;
  bool? isPost;

  setPosts(List<PostData> post) {
    _post.addAll(post);

    if (_post.isNotEmpty) {
      isPost = true;
    } else if (_post.isEmpty) {
      isPost = false;
    }
    notifyListeners();
  }

  clearPost() {
    _post = [];
    isPost = null;
    notifyListeners();
  }

  addPostInList(PostData post) {
    post.likesCount = '0';
    _post.insert(0, post);
    _userPost.insert(0, post);

    isPost = true;
    isUserPost = true;

    notifyListeners();
  }

  updatePost(PostData post) {
    _postDetail = post;
    final postIndex = _post.indexWhere((element) => element.id == post.id);
    if (postIndex != -1) {
      _post[postIndex] = post;
    }
    final userPostIndex =
        _userPost.indexWhere((element) => element.id == post.id);
    if (userPostIndex != -1) {
      _userPost[postIndex] = post;
    }

    notifyListeners();
  }

  //! <--------------------- delete post--------------->

  deletePost(String postId) {
    //! delete  post

    _post.removeWhere((element) => element.id == postId);

    //! delete post from user posts
    _userPost.removeWhere((element) => element.id == postId);

    notifyListeners();
  }

  //! <--------------------- post like update--------------->

  void postLikeUpdate({required bool isLike, required String postId}) {
    final postIndex = _post.indexWhere((element) => element.id == postId);
    if (postIndex != -1) {
      _post[postIndex].postLiked = isLike;

      int currentLikes = int.tryParse(_post[postIndex].likesCount ?? '0') ?? 0;
      _post[postIndex].likesCount = isLike
          ? (currentLikes + 1).toString()
          : (currentLikes > 0 ? (currentLikes - 1).toString() : '0');

      //! update post detail like

      if (_postDetail != null) {
        _postDetail?.postLiked = isLike;
        _postDetail?.likesCount = isLike
            ? (currentLikes + 1).toString()
            : (currentLikes > 0 ? (currentLikes - 1).toString() : '0');
      }

      //! update post like in user posts
      final userPostIndex =
          _userPost.indexWhere((element) => element.id == postId);
      if (userPostIndex != -1) {
        _userPost[userPostIndex].postLiked = isLike;

        int currentUserPostLikes =
            int.tryParse(_userPost[userPostIndex].likesCount ?? '0') ?? 0;
        _userPost[userPostIndex].likesCount = isLike
            ? (currentUserPostLikes + 1).toString()
            : (currentUserPostLikes > 0
                ? (currentUserPostLikes - 1).toString()
                : '0');
      }
      notifyListeners(); //! Ensure UI updates if using Provider
    }
  }

  //! <--------------------- get post details --------------->

  PostData? _postDetail;
  PostData? get postDetail => _postDetail;

  setPostDetail(PostData postDetail) {
    _postDetail = postDetail;
    notifyListeners();
  }

  //! <--------------------- add comment in post (post and post details)--------------->

  addCommentInPost(PostComment comment, String postId) {
    //! add comment in post

    final postIndex = _post.indexWhere((element) => element.id == postId);
    if (postIndex != -1) {
      _post[postIndex].comments?.insert(0, comment);
    }

    //! add comment in post details

    _postDetail?.comments?.insert(0, comment);

    //! add comment in user post

    final userPostIndex =
        _userPost.indexWhere((element) => element.id == postId);
    if (userPostIndex != -1) {
      _userPost[userPostIndex].comments?.insert(0, comment);
    }

    notifyListeners();
  }

  //! <--------------------- update comment in post ( post details)--------------->

  updateCommentInPostDetails(String comment, String commentId) {
    //! update comment in post details

    final commentIndex =
        _postDetail?.comments?.indexWhere((element) => element.id == commentId);
    if (commentIndex != -1) {
      _postDetail?.comments?[commentIndex!].content = comment;
    }

    notifyListeners();
  }

  //! <--------------------- delete comment in post (post and post details)--------------->

  deleteCommentFromPost(String commentId, String postId) {
    //! delete comment in post

    final postIndex = _post.indexWhere((element) => element.id == postId);
    if (postIndex != -1) {
      _post[postIndex]
          .comments
          ?.removeWhere((element) => element.id == commentId);
    }

    //! delete comment in post details

    _postDetail?.comments?.removeWhere((element) => element.id == commentId);

    //! delete comment in user post

    final userPostIndex =
        _userPost.indexWhere((element) => element.id == postId);
    if (userPostIndex != -1) {
      _userPost[userPostIndex]
          .comments
          ?.removeWhere((element) => element.id == commentId);
    }

    notifyListeners();
  }

//! <--------------------- add child comment in post (post and post details)--------------->

  addChildCommentInPost(PostComment comment, String postId, String parrentId) {
    //! add child comment in post

    //! final postIndex = _post.indexWhere((element) => element.id == postId);
    //! if (postIndex != -1) {
    //!   //! find parrent comment index
    //!   final parrentCommentIndex = _post[postIndex]
    //!       .comments
    //!       ?.indexWhere((element) => element.id == parrentId);

    //!   if (parrentCommentIndex != -1) {
    //!     _post[postIndex]
    //!         .comments?[parrentCommentIndex!]
    //!         .replies
    //!         ?.insert(0, comment);
    //!   }
    //! }

    //! add child comment in post details

    final parrentCommentIndex =
        _postDetail?.comments?.indexWhere((element) => element.id == parrentId);

    if (parrentCommentIndex != -1) {
      _postDetail?.comments?[parrentCommentIndex!].replies?.insert(0, comment);
    }

    notifyListeners();
  }

  //! <--------------------- delete child comment in post (post details)--------------->

  deleteChildCommentFromPost(String commentId, String parrentId) {
    //! delete child comment in post details

    final parrentIndex =
        _postDetail?.comments?.indexWhere((element) => element.id == parrentId);
    if (parrentIndex != -1) {
      _postDetail?.comments?[parrentIndex!].replies
          ?.removeWhere((element) => element.id == commentId);
    }

    notifyListeners();
  }

  //! <--------------------- update child comment in post ( post details)--------------->

  updateChildCommentInPostDetails(
      String comment, String commentId, String parrentId) {
    //! update comment in post details

    final parrentIndex =
        _postDetail?.comments?.indexWhere((element) => element.id == parrentId);
    if (parrentIndex != -1) {
      final commentIndex = _postDetail?.comments?[parrentIndex!].replies
          ?.indexWhere((element) => element.id == commentId);
      if (commentIndex != -1) {
        _postDetail?.comments?[parrentIndex!].replies?[commentIndex!].content =
            comment;
      }
    }

    notifyListeners();
  }

  //! <--------------------- update comment like in post ( post details)--------------->

  updateCommentLikeInPostDetail({
    required String commentId,
    parrentId,
    required bool isLiked,
    isChild,
  }) {
    //! update  comment, child comment like in post details

    if (!isChild) {
      log('comment my');
      //! update child replies like
      final commentIndex = _postDetail?.comments
          ?.indexWhere((element) => element.id == commentId);

      if (commentIndex != -1) {
        _postDetail?.comments?[commentIndex!].commentLiked = isLiked;
        _postDetail?.comments?[commentIndex!].likeCount = (int.tryParse(
                    _postDetail?.comments?[commentIndex].likeCount ?? '0') ??
                0 + (isLiked ? 1 : -1))
            .toString();
      }
    } else if (isChild) {
      log('comment reply my');

      //! update child replies like
      final parrentIndex = _postDetail?.comments
          ?.indexWhere((element) => element.id == parrentId);

      if (parrentIndex != -1) {
        log('parrent index mil gya');

        final childCommentIndex = _postDetail?.comments?[parrentIndex!].replies
            ?.indexWhere((element) => element.id == commentId);

        if (parrentIndex != -1 && childCommentIndex != -1) {
          log('reply index mil gya');

          var reply = _postDetail
              ?.comments?[parrentIndex!].replies?[childCommentIndex!];

          if (reply != null) {
            reply.replyLiked = isLiked;

            // Ensure safe parsing
            int currentCount =
                int.tryParse(reply.commentReplyCount ?? '0') ?? 0;

            // Update count
            currentCount += isLiked ? 1 : -1;
            reply.commentReplyCount = currentCount.toString();

            log('Updated commentReplyCount: ${reply.commentReplyCount}');

            notifyListeners(); // Ensure UI updates
          } else {
            log('Reply not found!');
          }
        }

        // if (childCommentIndex != -1) {
        //   log('reply index mil gya');

        //   _postDetail?.comments?[parrentIndex!].replies?[childCommentIndex!]
        //       .replyLiked = isLiked;
        //   log('before count: ${_postDetail?.comments?[parrentIndex!].replies?[childCommentIndex!].commentReplyCount}');

        //   _postDetail?.comments?[parrentIndex!].replies?[childCommentIndex!]
        //       .commentReplyCount = (int.tryParse(_postDetail
        //                   ?.comments?[parrentIndex]
        //                   .replies?[childCommentIndex]
        //                   .commentReplyCount
        //                   .toString() ??
        //               '0') ??
        //           0 + (isLiked ? 1 : -1))
        //       .toString();

        //   log('after count: ${_postDetail?.comments?[parrentIndex!].replies?[childCommentIndex!].commentReplyCount}');
        // }
      }
    }
    notifyListeners();
  }

  //! <--------------------- get all group --------------->

  List<GroupModel> _group = [];
  List<GroupModel> get group => _group;
  bool? isGroup;

  setGroup(List<GroupModel> group) {
    _group = group;
    if (_group.isEmpty) {
      isGroup = false;
    } else if (_group.isNotEmpty) {
      isGroup = true;
    }
    notifyListeners();
  }

  updateGroupStatus(String status, groupId) {
    final groupIndex = _group.indexWhere((element) => element.id == groupId);
    if (groupIndex != -1) {
      _group[groupIndex].status = status;
    }
    notifyListeners();
  }

  emptyGroup() {
    _group = [];
    isGroup = null;
    notifyListeners();
  }

  addGroupInList(GroupModel group) {
    _group.add(group);
    isGroup = true;
    notifyListeners();
  }

  deleteGroupFromList(String groupId) {
    _group.removeWhere((element) => element.id == groupId);
    if (_group.isEmpty) {
      isGroup = false;
    } else if (_group.isNotEmpty) {
      isGroup = true;
    }
    notifyListeners();
  }

  updateGroupInList(GroupModel group) {
    final groupIndex = _group.indexWhere((element) => element.id == group.id);

    if (groupIndex != -1) {
      _group[groupIndex] = group;
      notifyListeners();
    }
  }

  //! <--------------------- get group details --------------->

  GroupModel? _groupDetail;
  GroupModel? get groupDetail => _groupDetail;
  setGroupDetail(GroupModel group) {
    _groupDetail = group;
    notifyListeners();
  }

  //! <--------------------- get all group member --------------->

  List<GroupMemberModel> _groupMember = [];
  List<GroupMemberModel> get groupMember => _groupMember;
  bool? isGroupMember;

  setGroupMember(List<GroupMemberModel> groupMember) {
    _groupMember = groupMember;
    if (_groupMember.isEmpty) {
      isGroupMember = false;
    } else if (_groupMember.isNotEmpty) {
      isGroupMember = true;
    }
    notifyListeners();
  }

  updateGroupMember({required String type, memberId}) {
    if (type == 'add_member') {
      final memberIndex =
          _groupMember.indexWhere((element) => element.member?.id == memberId);

      if (memberIndex != -1) {
        _groupMember[memberIndex].status = 'approved';
      }
    } else if (type == 'delete_member') {
      _groupMember.removeWhere((element) => element.member?.id == memberId);
    }
    notifyListeners();
  }

  emptyGroupMember() {
    _groupMember = [];
    isGroupMember = null;

    notifyListeners();
  }

  //! <--------------------- clear post provider --------------->

  clearPostProvider() {
    _post = [];
    isPost = null;
    _userPost = [];
    isUserPost = null;
    _postDetail = null;
    _group = [];
    isGroup = null;
    notifyListeners();
  }
}
