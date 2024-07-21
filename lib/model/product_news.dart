class ProductNews {
  int? newsID;
  int? productID;
  int? userID;

  ProductNews({
    this.newsID,
    this.productID,
    this.userID,
  });

  factory ProductNews.fromJson(Map<String, dynamic> json) {
    return ProductNews(
      newsID: json['newsID'],
      productID: json['productID'],
      userID: json['userID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'newsID': newsID,
      'productID': productID,
      'userID': userID,
    };
  }
}
