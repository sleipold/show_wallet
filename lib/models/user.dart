class User {
  final String userDocumentId;
  final String fullName;
  final String email;
  final String userRole;
  final String teamDocumentId;

  User(
      {this.userDocumentId,
      this.fullName,
      this.email,
      this.userRole,
      this.teamDocumentId});

  User.fromData(Map<String, dynamic> data)
      : userDocumentId = data['userDocumentId'],
        fullName = data['fullName'],
        email = data['email'],
        userRole = data['userRole'],
        teamDocumentId = data['teamDocumentId'];

  Map<String, dynamic> toJson() {
    return {
      'userDocumentId': userDocumentId,
      'fullName': fullName,
      'email': email,
      'userRole': userRole,
      'teamDocumentId': teamDocumentId,
    };
  }
}
