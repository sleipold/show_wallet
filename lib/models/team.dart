class Team {
  final String id;
  final String name;
  final double balance;

  Team({this.id, this.name, this.balance});

  Team.fromData(Map<String, dynamic> data)
      : id = data['id'],
        name = data['name'],
        balance = data['balance'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'balance': balance,
    };
  }
}
