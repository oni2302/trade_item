class UserPermission {
  int? permissionID;
  int? userID;

  UserPermission({
    this.permissionID,
    this.userID,
  });

  factory UserPermission.fromJson(Map<String, dynamic> json) {
    return UserPermission(
      permissionID: json['permissionID'],
      userID: json['userID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'permissionID': permissionID,
      'userID': userID,
    };
  }
}
