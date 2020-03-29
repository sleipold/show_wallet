import 'package:flutter/foundation.dart';
import 'package:showwallet/constants/route_names.dart';
import 'package:showwallet/locator.dart';
import 'package:showwallet/services/authentication_service.dart';
import 'package:showwallet/services/dialog_service.dart';
import 'package:showwallet/services/navigation_service.dart';

import 'base_model.dart';

class SignUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  String _selectedRole = 'Select a User Role';

  String get selectedRole => _selectedRole;

  String _selectedTeam = 'Select a Team';

  String get selectedTeam => _selectedTeam;

  void setSelectedRole(dynamic role) {
    _selectedRole = role;
    notifyListeners();
  }

  void setSelectedTeam(dynamic team) {
    _selectedTeam = team;
    notifyListeners();
  }

  Future signUp({
    @required String email,
    @required String password,
    @required String fullName,
  }) async {
    setBusy(true);

    var result = await _authenticationService.signUpWithEmail(
        email: email,
        password: password,
        fullName: fullName,
        role: _selectedRole,
        teamDocumentId: _selectedTeam);

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(HomeViewRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Sign Up Failure',
          description: 'General sign up failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Sign Up Failure',
        description: result,
      );
    }
  }
}
