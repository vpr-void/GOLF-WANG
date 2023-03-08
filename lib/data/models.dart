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

class Item {
  final String name;
  final String description;
  final double price;
  final bool isNew;
  final bool isFav;
  final ItemSizes size;
  final ItemTypes itemTypes;
  final List<ItemDesign> designs;

  Item({
    required this.name,
    required this.description,
    required this.price,
    required this.isNew,
    required this.isFav,
    required this.size,
    required this.itemTypes,
    required this.designs,
  });
}

class ItemDesign {
  final String img;
  final Color color;

  ItemDesign(this.img, this.color);
}
