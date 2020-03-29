import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:showwallet/models/debt.dart';
import 'package:showwallet/models/post.dart';
import 'package:showwallet/models/team.dart';
import 'package:showwallet/models/user.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection('users');
  final CollectionReference _teamsCollectionReference =
      Firestore.instance.collection('teams');
  final CollectionReference _debtsCollectionReference =
      Firestore.instance.collection('debts');
  final CollectionReference _postsCollectionReference =
      Firestore.instance.collection('posts');

  final StreamController<List<Post>> _postsController =
      StreamController<List<Post>>.broadcast();
  final StreamController<List<Team>> _teamsController =
      StreamController<List<Team>>.broadcast();

  // === User ===

  Future createUser(User user) async {
    try {
      await _usersCollectionReference
          .document(user.userDocumentId)
          .setData(user.toJson());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future getUser(String userDocumentId) async {
    try {
      var user = await _usersCollectionReference.document(userDocumentId).get();
      return User.fromData(user.data);
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  // === Post ===

  Future addPost(Post post) async {
    try {
      await _postsCollectionReference.add(post.toMap());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future getPostsOnceOff() async {
    try {
      var postDocumentSnapshot = await _postsCollectionReference.getDocuments();
      if (postDocumentSnapshot.documents.isNotEmpty) {
        return postDocumentSnapshot.documents
            .map((snapshot) => Post.fromMap(snapshot.data, snapshot.documentID))
            .where((mappedItem) => mappedItem.title != null)
            .toList();
      }
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Stream listenToPostsRealTime() {
    // Register the handler for when the posts data changes
    _postsCollectionReference.snapshots().listen((postsSnapshot) {
      if (postsSnapshot.documents.isNotEmpty) {
        var posts = postsSnapshot.documents
            .map((snapshot) => Post.fromMap(snapshot.data, snapshot.documentID))
            .where((mappedItem) => mappedItem.title != null)
            .toList();

        // Add the posts onto the controller
        _postsController.add(posts);
      }
    });

    // Return the stream underlying our _postsController.
    return _postsController.stream;
  }

  Future deletePost(String documentId) async {
    await _postsCollectionReference.document(documentId).delete();
  }

  Future updatePost(Post post) async {
    try {
      await _postsCollectionReference
          .document(post.documentId)
          .updateData(post.toMap());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  // === Team ===
  Stream listenToTeamsRealTime() {
    // Register the handler for when the posts data changes
    _teamsCollectionReference.snapshots().listen((teamsSnapshot) {
      if (teamsSnapshot.documents.isNotEmpty) {
        var teams = teamsSnapshot.documents
            .map((snapshot) => Team.fromMap(snapshot.data, snapshot.documentID))
            .where((mappedItem) => mappedItem.name != null)
            .toList();

        // Add the teams onto the controller
        _teamsController.add(teams);
      }
    });

    // Return the stream underlying our _teamsController.
    return _teamsController.stream;
  }

  Future getTeam(String teamDocumentId) async {
    try {
      var team = await _teamsCollectionReference.document(teamDocumentId).get();
      return Team.fromData(team.data);
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future getDebt(String debtDocumentId) async {
    try {
      var debt = await _debtsCollectionReference.document(debtDocumentId).get();
      return Debt.fromData(debt.data);
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }
}
