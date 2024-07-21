class Comment {
  int? userID;
  int? newsID;
  String? contentComment;
  String? timeComment;

  Comment({
    this.userID,
    this.newsID,
    this.contentComment,
    this.timeComment,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      userID: json['userID'],
      newsID: json['newsID'],
      contentComment: json['contentComment'],
      timeComment: json['timeComment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userID': userID,
      'newsID': newsID,
      'contentComment': contentComment,
      'timeComment': timeComment,
    };
  }
}
