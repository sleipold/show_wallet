import 'package:flutter/widgets.dart';
import 'package:showwallet/locator.dart';
import 'package:showwallet/models/team.dart';
import 'package:showwallet/models/user.dart';
import 'package:showwallet/services/authentication_service.dart';

class BaseModel extends ChangeNotifier {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  User get currentUser => _authenticationService.currentUser;

  Team get currentTeam => _authenticationService.currentTeam;

  bool _busy = false;

  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
