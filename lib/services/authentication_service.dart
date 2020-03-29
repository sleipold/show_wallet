import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:showwallet/locator.dart';
import 'package:showwallet/models/team.dart';
import 'package:showwallet/models/user.dart';
import 'package:showwallet/services/firestore_service.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();

  User _currentUser;

  User get currentUser => _currentUser;

  Team _currentTeam;

  Team get currentTeam => _currentTeam;

  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _populateCurrentUser(authResult.user);
      await _populateCurrentTeam(currentUser.teamDocumentId);
      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future signUpWithEmail({
    @required String email,
    @required String password,
    @required String fullName,
    @required String role,
    @required String teamDocumentId,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // create a new user profile on firestore
      _currentUser = User(
        userDocumentId: authResult.user.uid,
        email: email,
        fullName: fullName,
        userRole: role,
        teamDocumentId: teamDocumentId,
      );

      await _firestoreService.createUser(_currentUser);

      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future<bool> isUserLoggedIn() async {
    var user = await _firebaseAuth.currentUser();
    await _populateCurrentUser(user);
    await _populateCurrentTeam(currentUser.teamDocumentId);
    return user != null;
  }

  Future _populateCurrentUser(FirebaseUser user) async {
    if (user != null) {
      _currentUser = await _firestoreService.getUser(user.uid);
    }
  }

  Future _populateCurrentTeam(String teamDocumentId) async {
    if (teamDocumentId != null && teamDocumentId != "") {
      _currentTeam = await _firestoreService.getTeam(teamDocumentId);
    }
  }
}
