import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:showwallet/locator.dart';
import 'package:showwallet/models/debt.dart';
import 'package:showwallet/models/team.dart';
import 'package:showwallet/models/user.dart';
import 'package:showwallet/services/firestore_service.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();

  User _currentUser;
  Team _currentTeam;
  Debt _currentDebt;

  User get currentUser => _currentUser;

  Team get currentTeam => _currentTeam;

  Debt get currentDebt => _currentDebt;

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
      await _populateCurrentDebt(currentUser.debtDocumentId);
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
    @required String debtDocumentId,
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
        debtDocumentId: debtDocumentId,
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
    return user != null;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future _populateCurrentUser(FirebaseUser user) async {
    if (user != null) {
      _currentUser = await _firestoreService.getUser(user.uid);
    }
  }

  Future _populateCurrentTeam(String teamDocumentId) async {
    if (teamDocumentId != null) {
      _currentTeam = await _firestoreService.getTeam(teamDocumentId);
    }
  }

  Future _populateCurrentDebt(String debtDocumentId) async {
    if (debtDocumentId != null && debtDocumentId != "") {
      _currentDebt = await _firestoreService.getDebt(debtDocumentId);
    }
  }
}
