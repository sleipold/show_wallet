class User {
  final String id;
  final String fullName;
  final String email;
  final String userRole;
  final String team;

  User({this.id, this.fullName, this.email, this.userRole, this.team});

  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        fullName = data['fullName'],
        email = data['email'],
        userRole = data['userRole'],
        team = data['team'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'userRole': userRole,
      'team': team,
    };
  }
}
