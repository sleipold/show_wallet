import 'package:flutter/material.dart';

class Debt {
  final String debtDocumentId;
  final String teamDocumentId;
  final String userDocumentId;
  final String value;

  Debt({@required this.debtDocumentId,
    @required this.teamDocumentId,
    @required this.userDocumentId,
    @required this.value});

  Debt.fromData(Map<String, dynamic> data)
      : debtDocumentId = data['debtDocumentId'],
        teamDocumentId = data['teamDocumentId'],
        userDocumentId = data['userDocumentId'],
        value = data['value'];
}