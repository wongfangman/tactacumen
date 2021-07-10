import 'package:flutter/material.dart';

class SellerPick {
  final int id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;

  SellerPick({
    @required this.id,
    @required this.images,
    @required this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    @required this.title,
    @required this.price,
    @required this.description,
  });
}

List<SellerPick> demoProducts = [
  SellerPick(
    id: 1,
    images: [
      "assets/images/MAL-24.jpg",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "MAL-24 (2.5HP) Malcomair Portable Direct Driven Air Compressor",
    price: 370.00,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  SellerPick(
    id: 2,
    images: [
      "assets/images/MAL-50.jpg",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "MAL-50 (3HP) Malcomair Portable Direct Driven Air Compressor",
    price: 430.00,
    description: description,
    rating: 4.1,
    isPopular: true,
  ),
  SellerPick(
    id: 3,
    images: [
      "assets/images/MAL-1500-30.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "MAL-1500-30 (2HP) Malcomair Oil-Free Air Compressor",
    price: 600.00,
    description: description,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  SellerPick(
    id: 4,
    images: [
      "assets/images/MAL-1500-50.png",
    ],
    colors: [
      Color(0xFFF6625E),
      Color(0xFF836DB8),
      Color(0xFFDECB9C),
      Colors.white,
    ],
    title: "MAL-1500-50 (2HP) Malcomair Oil-Free Air Compressor",
    price: 690.00,
    description: description,
    rating: 4.1,
    isFavourite: true,
  ),
];

const String description = "";
