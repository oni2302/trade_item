class User {
  String? nameUser;
  String? emailUser;
  String? passwordUser;
  String? phoneUser;
  String? avatarUser;

  User({
    this.nameUser,
    this.emailUser,
    this.passwordUser,
    this.phoneUser,
    this.avatarUser,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      nameUser: json['nameUser'],
      emailUser: json['emailUser'],
      passwordUser: json['passwordUser'],
      phoneUser: json['phoneUser'],
      avatarUser: json['avatarUser'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nameUser': nameUser,
      'emailUser': emailUser,
      'passwordUser': passwordUser,
      'phoneUser': phoneUser,
      'avatarUser': avatarUser,
    };
  }
}
