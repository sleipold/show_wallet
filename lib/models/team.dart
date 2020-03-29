import 'package:flutter/material.dart';

class Team {
  final String teamDocumentId;
  final String name;
  final String balance;

  Team({@required this.teamDocumentId, @required this.name, this.balance});

  Team.fromData(Map<String, dynamic> data)
      : teamDocumentId = data['teamDocumentId'],
        name = data['name'],
        balance = data['balance'];

  static Team fromMap(Map<String, dynamic> map, String teamDocumentId) {
    if (map == null) return null;

    return Team(
      teamDocumentId: map['teamDocumentId'],
      name: map['name'],
      balance: map['balance'],
    );
  }

//TODO: Add toJson function to update firestore entry of team (see user.dart)
}
