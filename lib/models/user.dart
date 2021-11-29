import 'package:flutter/foundation.dart';

class User extends ChangeNotifier {
  /// Internal, private state of the user.
  late String _userId;

  ///
  void setUserId(String userId) {
    _userId = userId;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Get the user id when needed
  String getUserId() {
    return _userId;
  }

}