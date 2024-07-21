class Product {
  int? categoryID;
  int? subCategoryID;
  String? nameProduct;
  String? imgProduct;
  String? pricesProduct;
  String? status;
  String? imgSlide1;
  String? imgSlide2;
  String? imgSlide3;
  String? imgSlide4;

  Product({
    this.categoryID,
    this.subCategoryID,
    this.nameProduct,
    this.imgProduct,
    this.pricesProduct,
    this.status,
    this.imgSlide1,
    this.imgSlide2,
    this.imgSlide3,
    this.imgSlide4,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      categoryID: json['categoryID'],
      subCategoryID: json['subCategoryID'],
      nameProduct: json['nameProduct'],
      imgProduct: json['imgProduct'],
      pricesProduct: json['pricesProduct'],
      status: json['status'],
      imgSlide1: json['imgSlide1'],
      imgSlide2: json['imgSlide2'],
      imgSlide3: json['imgSlide3'],
      imgSlide4: json['imgSlide4'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryID': categoryID,
      'subCategoryID': subCategoryID,
      'nameProduct': nameProduct,
      'imgProduct': imgProduct,
      'pricesProduct': pricesProduct,
      'status': status,
      'imgSlide1': imgSlide1,
      'imgSlide2': imgSlide2,
      'imgSlide3': imgSlide3,
      'imgSlide4': imgSlide4,
    };
  }
}
