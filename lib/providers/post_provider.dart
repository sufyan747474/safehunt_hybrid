import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:safe_hunt/model/user_model.dart';
import 'package:safe_hunt/screens/post/model/post_model.dart';

class PostProvider extends ChangeNotifier {
  // <---------------------------- Get All Tag People  -------------------------->

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

  // <----------------------------  Tag people (only show in ui)  -------------------------->

  List<UserData> _tagPeopleList = [];
  List<UserData> get tagPeopleList => _tagPeopleList;

  setTagPeopleList(List<UserData> tagPeopleList) {
    if (tagPeopleList.isNotEmpty) {
      _tagPeopleList = tagPeopleList;
    }
    // notifyListeners();
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

  // <---------------------------- Get Selected Tag People Id  -------------------------->

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
    _selectedTagpeople.remove(id);
    _tagPeopleList.removeWhere((element) => element.id == id);

    log('Tag People Length ${_selectedTagpeople.length}');
    notifyListeners();
  }

  emptySelectedTagPeople({bool isNotifyListner = true}) {
    _selectedTagpeople = [];
    log('Tag People Length ${_selectedTagpeople.length}');
    isNotifyListner ? notifyListeners() : null;
  }

  // <--------------------- get all post --------------->

  List<PostData> _post = [];
  List<PostData> get post => _post;
  bool? isPost;

  setPosts(List<PostData> post) {
    if (post.isNotEmpty) {
      _post = post;
      isPost = true;
    } else if (post.isEmpty) {
      isPost = false;
    }
    notifyListeners();
  }

  // <--------------------- delete post--------------->

  deletePost(String postId) {
    // delete  post

    _post.removeWhere((element) => element.id == postId);

    notifyListeners();
  }

  void postLikeUpdate({required bool isLike, required String postId}) {
    final postIndex = _post.indexWhere((element) => element.id == postId);
    if (postIndex != -1) {
      _post[postIndex].postLiked = isLike;

      int currentLikes = int.tryParse(_post[postIndex].likesCount ?? '0') ?? 0;
      _post[postIndex].likesCount = isLike
          ? (currentLikes + 1).toString()
          : (currentLikes > 0 ? (currentLikes - 1).toString() : '0');

      // update post detail like

      if (_postDetail != null) {
        _postDetail?.postLiked = isLike;
        _postDetail?.likesCount = isLike
            ? (currentLikes + 1).toString()
            : (currentLikes > 0 ? (currentLikes - 1).toString() : '0');
      }

      notifyListeners(); // Ensure UI updates if using Provider
    }
  }

  // <--------------------- get post details --------------->

  PostData? _postDetail;
  PostData? get postDetail => _postDetail;

  setPostDetail(PostData postDetail) {
    _postDetail = postDetail;
    notifyListeners();
  }

  // <--------------------- add comment in post (post and post details)--------------->

  addCommentInPost(PostComment comment, String postId) {
    // add comment in post

    final postIndex = _post.indexWhere((element) => element.id == postId);
    if (postIndex != -1) {
      _post[postIndex].comments?.insert(0, comment);
    }

    // add comment in post details

    _postDetail?.comments?.insert(0, comment);

    notifyListeners();
  }

  // <--------------------- add comment in post ( post details)--------------->

  updateCommentInPostDetails(String comment, String commentId) {
    // update comment in post details

    final commentIndex =
        _postDetail?.comments?.indexWhere((element) => element.id == commentId);
    if (commentIndex != -1) {
      _postDetail?.comments?[commentIndex!].content = comment;
    }

    notifyListeners();
  }

  // <--------------------- delete comment in post (post and post details)--------------->

  deleteCommentFromPost(String commentId, String postId) {
    // delete comment in post

    final postIndex = _post.indexWhere((element) => element.id == postId);
    if (postIndex != -1) {
      _post[postIndex]
          .comments
          ?.removeWhere((element) => element.id == commentId);
    }

    // delete comment in post details

    _postDetail?.comments?.removeWhere((element) => element.id == commentId);

    notifyListeners();
  }

// <--------------------- add child comment in post (post and post details)--------------->

  addChildCommentInPost(PostComment comment, String postId, String parrentId) {
    // add child comment in post

    // final postIndex = _post.indexWhere((element) => element.id == postId);
    // if (postIndex != -1) {
    //   // find parrent comment index
    //   final parrentCommentIndex = _post[postIndex]
    //       .comments
    //       ?.indexWhere((element) => element.id == parrentId);

    //   if (parrentCommentIndex != -1) {
    //     _post[postIndex]
    //         .comments?[parrentCommentIndex!]
    //         .replies
    //         ?.insert(0, comment);
    //   }
    // }

    // add child comment in post details

    final parrentCommentIndex =
        _postDetail?.comments?.indexWhere((element) => element.id == parrentId);

    if (parrentCommentIndex != -1) {
      _postDetail?.comments?[parrentCommentIndex!].replies?.insert(0, comment);
    }

    notifyListeners();
  }

  // <--------------------- delete child comment in post (post details)--------------->

  deleteChildCommentFromPost(String commentId, String parrentId) {
    // delete child comment in post details

    final parrentIndex =
        _postDetail?.comments?.indexWhere((element) => element.id == parrentId);
    if (parrentIndex != -1) {
      _postDetail?.comments?[parrentIndex!].replies
          ?.removeWhere((element) => element.id == commentId);
    }

    notifyListeners();
  }

  // <--------------------- clear post provider --------------->

  clearPostProvider() {
    _post = [];
    isPost = null;
    _postDetail = null;
    notifyListeners();
  }
}
