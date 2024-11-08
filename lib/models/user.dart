class User {
  final String uId;
  final String name;
  final String email;

  User({
    required this.uId,
    required this.name,
    required this.email,
  });

  // To compare two instances of User
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! User) return false;
    return uId == other.uId && name == other.name && email == other.email;
  }

  @override
  int get hashCode => Object.hash(uId, name, email);

  // A factory method to create a new User from a map (useful for JSON serialization)
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uId: map['uId'],
      name: map['name'],
      email: map['email'],
    );
  }

  // Convert the User instance to a map (useful for JSON serialization)
  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'name': name,
      'email': email,
    };
  }

  // Copy method to create a new instance with updated fields (immutability pattern)
  User copyWith({String? uId, String? name, String? email}) {
    return User(
      uId: uId ?? this.uId,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}