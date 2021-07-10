import 'package:flutter/material.dart';
import 'package:tactacumen/user/home/sellerpick.dart';

class Cart {
  final SellerPick product;
  final int numOfItems;

  Cart({@required this.product, @required this.numOfItems});
}

// Demo data for our dart
List<Cart> demoCarts = [
  Cart(product: demoProducts[0], numOfItems: 2),
  Cart(product: demoProducts[1], numOfItems: 1),
  Cart(product: demoProducts[2], numOfItems: 1),
];
