class Product {
  int? productId;
  String? productTitle;
  String? productDescription;
  String? produitImage;
  double? productPrice;

  Product({this.productId, this.productTitle, this.productDescription, this.productPrice});

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['produitId'];
    productTitle = json['produitLibelle'];
    productDescription = json['produitDescription'];
    produitImage = json['produitImage'];
    productPrice = json['produitPrix'];
  }
}