import 'package:flutter/material.dart';

/// ==================== BASE PRODUCT ====================
class Product {
  String _name;
  double _price;
  IconData _icon;
  String _category;
  String _description;
  double _rating;
  String _imageAsset;

  Product({
    required String name,
    required double price,
    required String category,
    IconData icon = Icons.shopping_bag,
    String description = "",
    double rating = 0.0,
    String imageAsset = "",
  }) : _name = name,
       _price = price,
       _icon = icon,
       _category = category,
       _description = description,
       _rating = rating,
       _imageAsset = imageAsset;

  // ===== Getter =====
  String get name => _name;
  double get price => _price;
  IconData get icon => _icon;
  String get category => _category;
  String get description => _description;
  double get rating => _rating;
  String get imageAsset => _imageAsset;

  // ===== Setter =====
  set name(String value) {
    if (value.isNotEmpty) _name = value;
  }

  set price(double value) {
    if (value > 0) _price = value;
  }

  set icon(IconData value) => _icon = value;
  set description(String value) => _description = value;

  set rating(double value) {
    if (value >= 0 && value <= 5) _rating = value;
  }

  set imageAsset(String value) => _imageAsset = value;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Product &&
        other.name == name &&
        other.price == price &&
        other.category == category;
  }

  @override
  int get hashCode => name.hashCode ^ price.hashCode ^ category.hashCode;
}

/// ==================== SUBCLASS: SKINCARE ====================
class SkincareProduct extends Product {
  SkincareProduct({
    required String name,
    required double price,
    required IconData icon,
    String description = "",
    double rating = 0.0,
    String imageAsset = "",
  }) : super(
         name: name,
         price: price,
         icon: icon,
         category: "Skincare",
         description: description,
         rating: rating,
         imageAsset: imageAsset,
       );
}

/// ==================== SUBCLASS: HAIRCARE ====================
class HaircareProduct extends Product {
  HaircareProduct({
    required String name,
    required double price,
    required IconData icon,
    String description = "",
    double rating = 0.0,
    String imageAsset = "",
  }) : super(
         name: name,
         price: price,
         icon: icon,
         category: "Haircare",
         description: description,
         rating: rating,
         imageAsset: imageAsset,
       );
}

/// ==================== SUBCLASS: BODYCARE ====================
class BodycareProduct extends Product {
  BodycareProduct({
    required String name,
    required double price,
    required IconData icon,
    String description = "",
    double rating = 0.0,
    String imageAsset = "",
  }) : super(
         name: name,
         price: price,
         icon: icon,
         category: "Bodycare",
         description: description,
         rating: rating,
         imageAsset: imageAsset,
       );
}
