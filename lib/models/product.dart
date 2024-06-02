import 'package:tisad_shop_app/models/vendor.dart';

class Product{
  int? id;
  String? vendor_id;
  String? p_name;
  String? description;
  String? price;
  String? stock;
  String? image;
  String? category_id;

  Product({
    this.id,
    this.vendor_id,
    this.p_name,
    this.description,
    this.price,
    this.stock,
    this.image,
    this.category_id
});

  factory Product.fromJson(Map<String,dynamic> json){
    return Product(
      id: json['id'],
      vendor_id: json['vendor_id'],
      p_name: json['p_name'],
      description: json['description'],
      price: json['price'],
      stock: json['stock'],
      image: json['image'],
      category_id: json['category_id']
    );
  }
}