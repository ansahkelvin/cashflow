class UserModel {
  UserModel({required this.name, required this.balance, required this.email});

  UserModel.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          balance: json['balance']! as double,
          email: json['email'] as String,
        );

  final String name;
  final double balance;
  final String email;

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'balance': balance,
      'email': email,
    };
  }
}
