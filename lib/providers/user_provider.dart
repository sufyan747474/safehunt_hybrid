import 'package:flutter/foundation.dart';
import 'package:safe_hunt/model/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserData? _user;
  UserData? get user => _user;

  setUser(UserData? user) {
    _user = user;
    notifyListeners();
  }
}
