import 'package:flutter/material.dart';

enum ItemSizes {
  SM,
  MD,
  LG,
  XL,
  XX,
}

enum ItemTypes {
  tops,
  bottoms,
  tees,
  hats,
  accessories,
}

class Item with ChangeNotifier {
  final String id;
  String name;
  String description;
  double price;
  bool isNew;
  bool isFav;
  List<ItemSizes> sizes;
  ItemTypes itemType;
  List<ItemDesign> designs;

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.isNew = false,
    this.isFav = false,
    required this.sizes,
    required this.itemType,
    required this.designs,
  });

  void toggleFav() {
    isFav = !isFav;
  }
}

class ItemDesign {
  final String img;
  final Color color;

  ItemDesign(this.img, this.color);
}

class CartItem with ChangeNotifier {
  final String id;
  final String name;
  final ItemSizes size;
  final ItemDesign design;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.design,
    required this.size,
    required this.price,
    required this.quantity,
  });
}

class Order {
  final String id;
  final DateTime dateTime;
  final double total;
  final String buyerName;
  final List<CartItem> items;

  Order({
    required this.id,
    required this.dateTime,
    required this.total,
    required this.buyerName,
    required this.items,
  });
}
