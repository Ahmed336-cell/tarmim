import 'dart:convert';

class Product {
  final int? id;
  final String product_name;
  final String product_description;
  final double product_price;
  final String product_category;
  List<String>? product_images;

  Product({
    this.id,
    required this.product_name,
    required this.product_description,
    required this.product_price,
    required this.product_category,
    this.product_images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int?,
      product_name: json['product_name'] as String,
      product_description: json['product_description'] as String,
      product_price: (json['product_price'] as num).toDouble(),
      product_category: json['product_category'] as String,
      product_images: json['product_images'] != null
          ? (json['product_images'] is String
          ? List<String>.from(jsonDecode(json['product_images']))
          : List<String>.from(json['product_images']))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_name': product_name,
      'product_description': product_description,
      'product_price': product_price,
      'product_category': product_category,
      'product_images': product_images,
    };
  }

  // Adding the copyWith method
  Product copyWith({
    int? id,
    String? product_name,
    String? product_description,
    double? product_price,
    String? product_category,
    List<String>? product_images,
  }) {
    return Product(
      id: id ?? this.id,
      product_name: product_name ?? this.product_name,
      product_description: product_description ?? this.product_description,
      product_price: product_price ?? this.product_price,
      product_category: product_category ?? this.product_category,
      product_images: product_images ?? this.product_images,
    );
  }
}