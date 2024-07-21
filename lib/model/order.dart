class Order {
  int? productID;
  int? userID;

  Order({
    this.productID,
    this.userID,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      productID: json['productID'],
      userID: json['userID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productID': productID,
      'userID': userID,
    };
  }
}
