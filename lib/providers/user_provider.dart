import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:safe_hunt/model/user_model.dart';
import 'package:safe_hunt/screens/journals/model/journal_model.dart';
import 'package:safe_hunt/screens/journals/model/weather_model.dart';

class UserProvider extends ChangeNotifier {
  UserData? _user;
  UserData? get user => _user;

  setUser(UserData? user) {
    _user = user;
    notifyListeners();
  }

// <--------------------  wheather ------------------>
  WeatherModel? _wheather;
  WeatherModel? get wheather => _wheather;

  setWeather(WeatherModel? wheather) {
    _wheather = wheather;
    notifyListeners();
  }

  // <---------------- get all journal ------------------>

  List<JournalData> _journal = [];
  List<JournalData> get journal => _journal;

  bool? isJournal;

  setJournal(List<JournalData> journal) {
    if (journal.isNotEmpty) {
      _journal = journal;
      isJournal = true;
    } else if (journal.isEmpty) {
      isJournal = false;
    }
    notifyListeners();
  }

  addJournalInList(JournalData journal) {
    _journal.insert(0, journal);
    isJournal = true;
    notifyListeners();
  }

  updateJournal(JournalData journal) {
    final journalIndex =
        _journal.indexWhere((element) => element.id == journal.id);
    if (journalIndex != -1) {
      _journal[journalIndex] = journal;
      notifyListeners();
    }
  }

  deleteJournal(String id) {
    final journalIndex = _journal.indexWhere((element) => element.id == id);
    if (journalIndex != -1) {
      _journal.removeAt(journalIndex);
      if (_journal.isEmpty) {
        isJournal = false;
      }
      notifyListeners();
    }
  }

  // <---------- filter Journal -------------->

  List<JournalData> _filterJournalList = [];
  List<JournalData> get filterJournalList => _filterJournalList;
  bool? hasFilterJournalList;
  setFilterJournalList({required String title}) {
    if (title.isNotEmpty) {
      final searchList = _journal.where((element) =>
          // '${element.description} ${element.lastName}'
          element.title!.toLowerCase().contains(title.toLowerCase()));

      _filterJournalList = searchList.toList();
      if (_filterJournalList.isEmpty) {
        hasFilterJournalList = false;
      } else {
        hasFilterJournalList = true;
      }
      log('search Journal length : ${_filterJournalList.length}');
      notifyListeners();
    } else {
      hasFilterJournalList = null;
      _filterJournalList = [];
      log('search Journal length : ${_filterJournalList.length}');
      notifyListeners();
    }
  }

  emptyJournal() {
    _journal = [];
    isJournal = null;
    notifyListeners();
  }

  // <--------------------- clear user provider ------------------------->

  clearUserProvider() {
    _user = null;
    _journal = [];
    isJournal = null;
  }
}
