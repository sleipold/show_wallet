import 'package:flutter/material.dart';
import 'package:showwallet/locator.dart';
import 'package:showwallet/services/authentication_service.dart';
import 'package:showwallet/services/navigation_service.dart';

class MenuDrawer extends StatelessWidget {
  final AuthenticationService _authenticationService =
  locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  final String currentUserFullName;

  MenuDrawer({@required this.currentUserFullName});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              '$currentUserFullName',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: Text('Profile'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sign out'),
            onTap: () async {
              await _authenticationService.signOut();
              _navigationService.handleSignOut(context);
            },
          ),
        ],
      ),
    );
  }
}
