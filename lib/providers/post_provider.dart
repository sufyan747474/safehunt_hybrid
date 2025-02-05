import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:safe_hunt/model/user_model.dart';

class PostProvider extends ChangeNotifier {
  // <---------------------------- Get All Tag People  -------------------------->

  List<UserData> _getTagPeople = [];
  List<UserData> get getTagPeople => _getTagPeople;
  bool? hasTagPeople;

  setTagPeople(List<UserData> getTagPeople) {
    if (getTagPeople.isNotEmpty) {
      hasTagPeople = true;
      _getTagPeople = getTagPeople;
      // _getTagPeople = getTagPeople
      //   ..sort((a, b) =>
      //       DateTime.parse(b.createdAt ?? DateTime.now().toString()).compareTo(
      //           DateTime.parse(a.createdAt ?? DateTime.now().toString())));
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
}
