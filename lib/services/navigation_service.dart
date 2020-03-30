import 'package:flutter/material.dart';
import 'package:showwallet/constants/route_names.dart';

class NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  bool pop() {
    return _navigationKey.currentState.pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState
        .pushNamed(routeName, arguments: arguments);
  }
  void handleSignOut(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(LoginViewRoute, (Route<dynamic> route) => false);
  }
}
