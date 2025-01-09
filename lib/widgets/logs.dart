import 'dart:developer';

import 'package:flutter/foundation.dart';

void logs(String message) {
  if (kDebugMode) {
    log(message, name: "");
  }
}