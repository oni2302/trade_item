class Permission {
  String? namePermission;

  Permission({
    this.namePermission,
  });

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      namePermission: json['namePermission'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'namePermission': namePermission,
    };
  }
}
