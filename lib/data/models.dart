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
  final String name;
  final String description;
  final double price;
  final bool isNew;
  bool isFav;
  final List<ItemSizes> sizes;
  final ItemTypes itemType;
  final List<ItemDesign> designs;

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.isNew,
    required this.isFav,
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
